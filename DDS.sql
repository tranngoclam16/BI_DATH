use master
go
create database DDS
go
use DDS
go

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimPHU]') AND type in (N'U'))
  DROP TABLE [dbo].[DimPHU]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimDate]') AND type in (N'U'))
  DROP TABLE [dbo].[DimDate]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimGender]') AND type in (N'U'))
  DROP TABLE [dbo].[DimGender]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimExposure]') AND type in (N'U'))
  DROP TABLE [dbo].[DimExposure]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimAge]') AND type in (N'U'))
  DROP TABLE [dbo].[DimAge]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimOutcome]') AND type in (N'U'))
  DROP TABLE [dbo].[DimOutcome]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimSeverity]') AND type in (N'U'))
  DROP TABLE [dbo].[DimSeverity]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FactCaseDetail]') AND type in (N'U'))
  DROP TABLE [dbo].[FactCaseDetail]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FactVaccineDetail]') AND type in (N'U'))
  DROP TABLE [dbo].[FactVaccineDetail]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FactVaccineDetail]') AND type in (N'U'))
  DROP TABLE [dbo].[FactOutbreakDetail]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DimOutbreak]') AND type in (N'U'))
  DROP TABLE [dbo].[DimOutbreak]
GO

CREATE TABLE [dbo].[DimPHU] (
	PHUID_SK int identity (1,1) not null primary key
,	PHUID int not null
,	PHUName nvarchar(255) null
,	PHUAddress nvarchar(255) null
,	PHUWebsite nvarchar(255) null
,	PHULatitude nvarchar(255) null
,	PHULongitude nvarchar(255) null
,	CityID int null
,	CityName nvarchar(255) null
,	GroupID int null
,	GroupName nvarchar(255) null
,	[Status] int null
,	EffectiveDate datetime null
,	ExpiryDate datetime null
)

CREATE TABLE [dbo].[DimGender](
	GenderID int not null primary key
,	Gender nvarchar(255) null
)

CREATE TABLE [dbo].[DimExposure](
	ExposureID int not null primary key
,	ExposureName nvarchar(255) null
)

CREATE TABLE [dbo].[DimAge](
	AgeID int not null primary key
,	Age nvarchar(255) null
)

CREATE TABLE [dbo].[DimOutcome](
	OutcomeID int not null primary key
,	Outcome nvarchar(255) null
)

CREATE TABLE [dbo].[DimSeverity](
	SeverityID int identity(1,1) not null primary key
,	Severity nvarchar(255) null
)

CREATE TABLE [dbo].[DimOutbreak](
	OutbreakID int not null primary key
,	OutbreakGroup nvarchar(255) null
)

CREATE TABLE [dbo].[FactCaseDetail](
	PHUID int not null
,	DateID int not null
,	GenderID int not null
,	ExposureID int not null
,	AgeID int not null
,	OutcomeID int not null
,	SeverityID int not null
,	TotalCase int null
,	primary key (PHUID, DateID, GenderID, ExposureID, AgeID, OutcomeID, SeverityID)
)

CREATE TABLE [dbo].[FactVaccineDetail](
	DateID int not null
,	PHUID int not null
,	AgeID int not null
,	OneDoseCumulative int null
,	SecondDoseCumulative int null
,	FullyVaccinated int null
,	ThirdDoseCumulative int null
,	primary key (DateID, PHUID, AgeID)
)

CREATE TABLE [dbo].[FactOutbreakDetail](
	DateID int not null
,	PHUID int not null
,	OutbreakID int not null
,	NumberOngoingOutbreaks int null
,	primary key (DateID, PHUID, OutbreakID)
)
GO

INSERT INTO [dbo].[DimSeverity] VALUES ('Low'), ('Moderate'), ('High'), ('Critical')

go
DECLARE @StartDate  date = '20190101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 30, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    [Date]         = CONVERT(date, d),
	[Year]         = DATEPART(YEAR,      d),
	[Quarter]      = DATEPART(Quarter,   d),
	[Month]        = DATEPART(MONTH,     d),
	[MonthName]    = DATENAME(MONTH,     d),
    [Day]          = DATEPART(DAY,       d)
  FROM d
)
SELECT IDENTITY(int, 1,1) as DateID, * INTO DimDate FROM src 
  ORDER BY [Date]
  OPTION (MAXRECURSION 0);

GO
alter table DimDate
add primary key (DateID);

GO
ALTER TABLE [dbo].[FactCaseDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactCaseDetail_DimAge] FOREIGN KEY([AgeID])
REFERENCES [dbo].[DimAge] ([AgeID])
GO
ALTER TABLE [dbo].[FactCaseDetail] CHECK CONSTRAINT [FK_FactCaseDetail_DimAge]
GO
ALTER TABLE [dbo].[FactCaseDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactCaseDetail_DimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[DimDate] ([DateID])
GO
ALTER TABLE [dbo].[FactCaseDetail] CHECK CONSTRAINT [FK_FactCaseDetail_DimDate]
GO
ALTER TABLE [dbo].[FactCaseDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactCaseDetail_DimExposure] FOREIGN KEY([ExposureID])
REFERENCES [dbo].[DimExposure] ([ExposureID])
GO
ALTER TABLE [dbo].[FactCaseDetail] CHECK CONSTRAINT [FK_FactCaseDetail_DimExposure]
GO
ALTER TABLE [dbo].[FactCaseDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactCaseDetail_DimGender] FOREIGN KEY([GenderID])
REFERENCES [dbo].[DimGender] ([GenderID])
GO
ALTER TABLE [dbo].[FactCaseDetail] CHECK CONSTRAINT [FK_FactCaseDetail_DimGender]
GO
ALTER TABLE [dbo].[FactCaseDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactCaseDetail_DimOutcome] FOREIGN KEY([OutcomeID])
REFERENCES [dbo].[DimOutcome] ([OutcomeID])
GO
ALTER TABLE [dbo].[FactCaseDetail] CHECK CONSTRAINT [FK_FactCaseDetail_DimOutcome]
GO
ALTER TABLE [dbo].[FactCaseDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactCaseDetail_DimPHU] FOREIGN KEY([PHUID])
REFERENCES [dbo].[DimPHU] ([PHUID_SK])
GO
ALTER TABLE [dbo].[FactCaseDetail] CHECK CONSTRAINT [FK_FactCaseDetail_DimPHU]
GO
ALTER TABLE [dbo].[FactCaseDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactCaseDetail_DimSeverity] FOREIGN KEY([SeverityID])
REFERENCES [dbo].[DimSeverity] ([SeverityID])
GO
ALTER TABLE [dbo].[FactCaseDetail] CHECK CONSTRAINT [FK_FactCaseDetail_DimSeverity]
GO
ALTER TABLE [dbo].[FactVaccineDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactVaccineDetail_DimAge] FOREIGN KEY([AgeID])
REFERENCES [dbo].[DimAge] ([AgeID])
GO
ALTER TABLE [dbo].[FactVaccineDetail] CHECK CONSTRAINT [FK_FactVaccineDetail_DimAge]
GO
ALTER TABLE [dbo].[FactVaccineDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactVaccineDetail_DimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[DimDate] ([DateID])
GO
ALTER TABLE [dbo].[FactVaccineDetail] CHECK CONSTRAINT [FK_FactVaccineDetail_DimDate]
GO
ALTER TABLE [dbo].[FactVaccineDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactVaccineDetail_DimPHU] FOREIGN KEY([PHUID])
REFERENCES [dbo].[DimPHU] ([PHUID_SK])
GO
ALTER TABLE [dbo].[FactVaccineDetail] CHECK CONSTRAINT [FK_FactVaccineDetail_DimPHU]
GO
ALTER TABLE [dbo].[FactOutbreakDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactOutbreakDetail_DimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[DimDate] ([DateID])
GO
ALTER TABLE [dbo].[FactOutbreakDetail] CHECK CONSTRAINT [FK_FactOutbreakDetail_DimDate]
GO
ALTER TABLE [dbo].[FactOutbreakDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactOutbreakDetail_DimPHU] FOREIGN KEY([PHUID])
REFERENCES [dbo].[DimPHU] ([PHUID_SK])
GO
ALTER TABLE [dbo].[FactOutbreakDetail] CHECK CONSTRAINT [FK_FactOutbreakDetail_DimPHU]
GO
ALTER TABLE [dbo].[FactOutbreakDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactOutbreakDetail_DimOutbreak] FOREIGN KEY([OutbreakID])
REFERENCES [dbo].[DimOutbreak] ([OutbreakID])
GO
ALTER TABLE [dbo].[FactOutbreakDetail] CHECK CONSTRAINT [FK_FactOutbreakDetail_DimOutbreak]
GO