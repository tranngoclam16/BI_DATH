USE [Stage]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Drop:  Table [dbo].[CasesReport_Stage]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CasesReport_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[CasesReport_Stage]
GO

/****** Drop:  Table [dbo].[CompileCovid19CaseDetailsCanada_Stage]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompileCovid19CaseDetailsCanada_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[CompileCovid19CaseDetailsCanada_Stage]
GO

/****** Drop:  Table [dbo].[OngoingOutbreaksPHU_Stage]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OngoingOutbreaksPHU_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[OngoingOutbreaksPHU_Stage]
GO

/****** Drop:  Table [dbo].[PublicHealthUnit_Stage]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublicHealthUnit_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[PublicHealthUnit_Stage]
GO

/****** Drop:  Table [dbo].[PublicHealthUnitsGroup_Stage]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublicHealthUnitsGroup_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[PublicHealthUnitsGroup_Stage]
GO

/****** Drop:  Table [dbo].[VaccinesByAgePHU_Stage]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VaccinesByAgePHU_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[VaccinesByAgePHU_Stage]
GO


CREATE TABLE [dbo].[CasesReport_Stage](
	[Outcome] [varchar](50) NULL,
	[Age] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[ReportingPHU] [varchar](250) NULL,
	[SpecimenDate] [varchar](50) NULL,
	[CaseReportedDate] [varchar](50) NULL,
	[PHUCity] [varchar](50) NULL,
	[TestReportedDate] [varchar](50) NULL,
	[CaseAcquisitionInfo] [varchar](50) NULL,
	[AccurateEpisodeDt] [varchar](50) NULL,
	[PHUAddress] [varchar](50) NULL,
	[PHUWebsite] [varchar](250) NULL,
	[OutbreakRelated] [varchar](50) NULL,
	[PHULatitude] [varchar](50) NULL,
	[PHULongitude] [varchar](50) NULL,
	[PHUPostalCode] [varchar](50) NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL
)
GO

CREATE TABLE [dbo].[CompileCovid19CaseDetailsCanada_Stage](
	[ObjectId] [varchar](50) NOT NULL PRIMARY KEY,
	[RowId] [varchar](50) NULL,
	[DateReported] [varchar](50) NULL,
	[HealthRegion] [varchar](250) NULL,
	[AgeGroup] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[Exposure] [varchar](50) NULL,
	[CaseStatus] [varchar](50) NULL,
	[Province] [varchar](50) NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL
)
GO

CREATE TABLE [dbo].[OngoingOutbreaksPHU_Stage](
	[Date] [varchar](50) NULL,
	[PHUNum] [varchar](50) NULL,
	[OutbreakGroup] [varchar](50) NULL,
	[NumberOngoingOutbreaks] [varchar](50) NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL
) 
GO

CREATE TABLE [dbo].[PublicHealthUnit_Stage](
	[PHUID] [varchar](50) NOT NULL PRIMARY KEY,
	[ReportingPHU] [varchar](250) NULL,
	[ReportingPHUAddress] [varchar](50) NULL,
	[ReportingPHUCity] [varchar](50) NULL,
	[ReportingPHUPostalCode] [varchar](50) NULL,
	[ReportingPHUWebsite] [varchar](250) NULL,
	[ReportingPHULatitude] [varchar](50) NULL,
	[ReportingPHULongitude] [varchar](50) NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL
) 
GO

CREATE TABLE [dbo].[PublicHealthUnitsGroup_Stage](
	[PHUGroup] [varchar](50) NULL,
	[PHUCity] [varchar](50) NOT NULL PRIMARY KEY,
	[PHURegion] [varchar](250) NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL
) 
GO

CREATE TABLE [dbo].[VaccinesByAgePHU_Stage](
	[Date] [varchar](50) NULL,
	[PHUID] [varchar](50) NULL,
	[AgeGroup] [varchar](50) NULL,
	[At_least_one_dose_cumulative] [varchar](50) NULL,
	[Second_dose_cumulative] [varchar](50) NULL,
	[fully_vaccinated_cumulative] [varchar](50) NULL,
	[third_dose_cumulative] [varchar](50) NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL
) 
GO











