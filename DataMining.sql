ALTER VIEW vCaseDetail
AS
	SELECT 
		ROW_NUMBER() OVER (ORDER BY F.PHUID, F.DateID, F.GenderID) AS ID
		, DP.PHUName
		, DP.CityName
		, DP.GroupName
		, DD.Date
		,'Q' + CAST(DD.Quarter AS varchar) + '/' + CAST(DD.Year AS varchar) AS TimePeriod
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

-- Create table for mining and visualize
INSERT INTO miningCaseDetail
SELECT 
	ROW_NUMBER() OVER (ORDER BY F.PHUID, F.DateID, F.GenderID) AS ID
	, DP.PHUName
	, DP.CityName
	, DP.GroupName
	, DD.Date
	,'Q' + CAST(DD.Quarter AS varchar) + '/' + CAST(DD.Year AS varchar) AS TimePeriod
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
	, 0 as Label1
	, 0 as Label2 
FROM FactCaseDetail F
	JOIN DimPHU DP ON DP.PHUID_SK = F.PHUID
	JOIN DimDate DD ON DD.DateID = F.DateID
	JOIN DimGender DG ON DG.GenderID = F.GenderID
	JOIN DimExposure DE ON DE.ExposureID = F.ExposureID
	JOIN DimAge DA ON DA.AgeID = F.AgeID
	JOIN DimOutcome DO ON DO.OutcomeID = F.OutcomeID
	JOIN DimSeverity DS ON DS.SeverityID = F.SeverityID

SELECT *
FROM miningCaseDetail
where ID=1

UPDATE m
SET m.Label1 = p.Cluster
FROM miningCaseDetail as m inner join (select ID, [$CLUSTER] as Cluster from openquery([BI_DATH] , '
									SELECT    
										  t.[ID],   
										  Cluster() 
									FROM  
										[Clustering]
									NATURAL PREDICTION JOIN  
										OPENQUERY([Covid19],  
										''SELECT 
											ID,
											Age,
											Gender,
											Outcome,
											TimePeriod
										FROM miningCaseDetail
									'') AS t  ')) as p on m.ID=p.ID

go
CREATE PROCEDURE sp_AssignClusterLabel
AS
	select ID, [$CLUSTER] as Cluster INTO #TEMPTABLE
	from openquery([BI_DATH] , '
									SELECT    
										  t.[ID],   
										  Cluster() 
									FROM  
										[Clustering]
									NATURAL PREDICTION JOIN  
										OPENQUERY([Covid19],  
										''SELECT 
											ID,
											Age,
											Gender,
											Outcome,
											TimePeriod
										FROM miningCaseDetail
									'') AS t  ')

	UPDATE m
	SET m.Label1 = p.Cluster
	FROM miningCaseDetail as m inner join #TEMPTABLE as p on m.ID=p.ID
GO
SELECT * FROM miningCaseDetail