ALTER VIEW vCaseDetail
AS
	SELECT 
		ROW_NUMBER() OVER (ORDER BY F.PHUID, F.DateID, F.GenderID) AS ID
		, DP.PHUName
		, DP.CityName
		, DP.GroupName
		, DD.Date
		,'Q' + CAST(DD.Quarter AS varchar) + '/' + CAST(DD.Year AS varchar) AS TPeriod
		, DD.Year
		, DG.GenderID
		, DG.Gender
		, DE.ExposureID 
		, DE.ExposureName
		, DA.AgeID
		, DA.Age
		, DO.OutcomeID
		, DO.Outcome
		, DS.SeverityID
		, DS.Severity
	FROM FactCaseDetail F
		JOIN DimPHU DP ON DP.PHUID_SK = F.PHUID
		JOIN DimDate DD ON DD.DateID = F.DateID
		JOIN DimGender DG ON DG.GenderID = F.GenderID
		JOIN DimExposure DE ON DE.ExposureID = F.ExposureID
		JOIN DimAge DA ON DA.AgeID = F.AgeID
		JOIN DimOutcome DO ON DO.OutcomeID = F.OutcomeID
		JOIN DimSeverity DS ON DS.SeverityID = F.SeverityID
GO

SELECT * FROM [dbo].[FactCaseDetail] 
SELECT * FROM vCaseDetail WHERE ID = 1

SELECT 
	ROW_NUMBER() OVER (ORDER BY F.PHUID, F.DateID, F.GenderID) AS ID
	, DP.PHUName
	, DP.CityName
	, DP.GroupName
	, DD.Date
	,'Q' + CAST(DD.Quarter AS varchar) + '/' + CAST(DD.Year AS varchar) AS TimePeriod
	, DG.Gender
	, DE.ExposureName
	, DA.Age
	, DO.Outcome
	, DS.Severity
FROM FactCaseDetail F
	JOIN DimPHU DP ON DP.PHUID_SK = F.PHUID
	JOIN DimDate DD ON DD.DateID = F.DateID
	JOIN DimGender DG ON DG.GenderID = F.GenderID
	JOIN DimExposure DE ON DE.ExposureID = F.ExposureID
	JOIN DimAge DA ON DA.AgeID = F.AgeID
	JOIN DimOutcome DO ON DO.OutcomeID = F.OutcomeID
	JOIN DimSeverity DS ON DS.SeverityID = F.SeverityID


SELECT 
	ROW_NUMBER() OVER (ORDER BY F.PHUID, F.DateID, F.GenderID) AS ID
	, DP.PHUName
	, DP.CityName
	, DP.GroupName
	, DD.Date
	,'Q' + CAST(DD.Quarter AS varchar) + '/' + CAST(DD.Year AS varchar) AS TPeriod
	, DD.Year
	, DG.GenderID
	, DG.Gender
	, DE.ExposureID 
	, DE.ExposureName
	, DA.AgeID
	, DA.Age
	, DO.OutcomeID
	, DO.Outcome
	, DS.SeverityID
	, DS.Severity into miningCaseDetail
FROM FactCaseDetail F
	JOIN DimPHU DP ON DP.PHUID_SK = F.PHUID
	JOIN DimDate DD ON DD.DateID = F.DateID
	JOIN DimGender DG ON DG.GenderID = F.GenderID
	JOIN DimExposure DE ON DE.ExposureID = F.ExposureID
	JOIN DimAge DA ON DA.AgeID = F.AgeID
	JOIN DimOutcome DO ON DO.OutcomeID = F.OutcomeID
	JOIN DimSeverity DS ON DS.SeverityID = F.SeverityID

