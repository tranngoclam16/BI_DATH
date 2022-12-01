---- Fact Case Detail
insert into FactCaseDetail(PHUID, DateID, GenderID, AgeID, OutcomeID, SeverityID, TotalCase)
select l.PHUID, l.DateID, l.GenderID, l.AgeID, l.OutcomeID, ds.SeverityID, l.TotalCase from DimSeverity ds left join 
(select dp.PHUID as PHUID
, dd.DateID as DateID
, dg.GenderID as GenderID
, da.AgeID as AgeID
, do.OutcomeID as OutcomeID
, count(cc.CaseID) as TotalCase
, (CASE WHEN do.Outcome = 'Active' then 
			case when k.[Weight]+1 <= 1 then 'Low'
				 when k.[Weight]+1 <= 2 then 'Moderate'
				 when k.[Weight]+1 <= 3 then 'High'
				 when k.[Weight]+1 >= 4 then 'Critical' end
		WHEN do.Outcome = 'Deceased' then 
			case when k.[Weight]+4 >= 4 then 'Critical' end
		WHEN do.Outcome = 'Recovered' then 
			case when k.[Weight]+0 <= 1 then 'Low'
				 when k.[Weight]+0 <= 2 then 'Moderate'
				 when k.[Weight]+0 <= 3 then 'High'
				 when k.[Weight]+0 >= 4 then 'Critical' end
		ELSE NULL
		END) as [Severity]
from NDS.dbo.Covid19Cases cc
	left join DimPHU dp on dp.PHUID = cc.PHU_ID
	left join DimDate dd on dd.[Date] = convert(date,cc.DateReported)
	left join DimAge da on da.AgeID = cc.AgeID
	left join DimOutcome do on do.OutcomeID = cc.CaseStatus
	left join DimGender dg on dg.GenderID = cc.Gender
	left join (select AgeID, CASE 
WHEN Age = 0 THEN 0
WHEN Age < 30 THEN 0
WHEN Age <= 49 THEN 1
WHEN Age <= 69 THEN 2
WHEN Age <= 79 THEN 3
WHEN Age >= 80 THEN 4 else NULL end as [Weight] from(
select AgeID, CAST(reverse(Left(
             SubString(reverse(AgeGroup), PatIndex('%[0-9]%', reverse(AgeGroup)), 8000), 
             PatIndex('%[^0-9]%', SubString(reverse(AgeGroup), PatIndex('%[0-9]%', reverse(AgeGroup)), 8000) + 'X')-1)) as INT) as Age
from nds.dbo.AgeGroup) as t) k on k.AgeID = da.AgeID
where dp.[Status] = 1 and dp.ExpiryDate IS NULL
group by dp.PHUID, dd.DateID, dg.GenderID, da.AgeID, do.OutcomeID, cc.CaseID, do.Outcome, k.[Weight]) as l
on ds.Severity = l.Severity
where l.Severity IS NOT NULL AND
	NOT EXISTS (SELECT PHUID, DateID, GenderID, AgeID, OutcomeID, SeverityID FROM FactCaseDetail f where f.PHUID = l.PHUID and f.DateID = l.DateID and
																									f.GenderID = l.GenderID and f.AgeID = l.AgeID and
																									f.OutcomeID = l.OutcomeID and ds.SeverityID = f.SeverityID)
group by l.PHUID, l.DateID, l.GenderID, l.AgeID, l.OutcomeID, ds.SeverityID, l.TotalCase
order by l.DateID


---- FactVaccineDetail

insert into FactVaccineDetail(DateID, PHUID, AgeID, OneDoseCumulative, SecondDoseCumulative, FullyVaccinated, ThirdDoseCumulative)
select coalesce(dd.DateID, 0) as DateID
	, coalesce(dp.PHUID_SK, 0) as PHUID
	, coalesce(da.AgeID, 0) as AgeID
	, vc.At_least_one_dose_cumulative as OneDoseCumulative
	, vc.Second_dose_cumulative as SecondDoseCumulative
	, vc.fully_vaccinated_cumulative as FullyVaccinated
	, vc.third_dose_cumulative as ThirdDoseCumulative
from nds.dbo.VaccinesByAgePHU vc
	left join DimDate dd on dd.Date = convert(date, vc.Date)
	left join DimPHU dp on dp.PHUID = vc.PHU_ID
	left join DimAge da on da.AgeID = vc.AgeID
where dp.Status = 1 and dp.ExpiryDate IS NULL
	and not exists (select DateID, PHUID, AgeID from FactVaccineDetail f where f.AgeID = da.AgeID and f.DateID = dd.DateID and f.PHUID = dp.PHUID_SK)
group by dd.DateID, dp.PHUID_SK, da.AgeID, vc.At_least_one_dose_cumulative, vc.Second_dose_cumulative, vc.fully_vaccinated_cumulative, vc.third_dose_cumulative
order by dd.DateID
