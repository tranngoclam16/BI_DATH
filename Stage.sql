USE master
GO
CREATE DATABASE [Stage]
GO
USE [Stage]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Drop:  Table [dbo].[CasesReport]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CasesReport_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[CasesReport_Stage]
GO

/****** Drop:  Table [dbo].[CompileCovid19CaseDetailsCanada]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompileCovid19CaseDetailsCanada_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[CompileCovid19CaseDetailsCanada_Stage]
GO

/****** Drop:  Table [dbo].[OngoingOutbreaksPHU]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OngoingOutbreaksPHU_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[OngoingOutbreaksPHU_Stage]
GO

/****** Drop:  Table [dbo].[PublicHealthUnit]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublicHealthUnit_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[PublicHealthUnit_Stage]
GO

/****** Drop:  Table [dbo].[PublicHealthUnitsGroup]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublicHealthUnitsGroup_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[PublicHealthUnitsGroup_Stage]
GO

/****** Drop:  Table [dbo].[VaccinesByAgePHU]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VaccinesByAgePHU_Stage]') AND type in (N'U'))
DROP TABLE [dbo].[VaccinesByAgePHU_Stage]
GO


CREATE TABLE [dbo].[CasesReport_Stage](
	[ObjectID] [int] NOT NULL PRIMARY KEY,	
	[Outcome] [nvarchar](255) NULL,
	[Age] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	[ReportingPHU] [nvarchar](255) NULL,
	[SpecimenDate] [datetime] NULL,
	[CaseReportedDate] [datetime] NULL,
	[PHUCity] [nvarchar](255) NULL,
	[TestReportedDate] [datetime] NULL,
	[CaseAcquisitionInfo] [nvarchar](255) NULL,
	[AccurateEpisodeDt] [datetime] NULL,
	[PHUAddress] [nvarchar](255) NULL,
	[PHUWebsite] [nvarchar](255) NULL,
	[OutbreakRelated] [nvarchar](255) NULL,
	[PHULatitude] [nvarchar](50) NULL,
	[PHULongitude] [nvarchar](50) NULL,
	[PHUPostalCode] [nvarchar](255) NULL,
	[Status] int null
)
GO

CREATE TABLE [dbo].[CompileCovid19CaseDetailsCanada_Stage](
	[ObjectId] [int] NOT NULL PRIMARY KEY,
	[DateReported] [datetime] NULL,
	[HealthRegion] [nvarchar](255) NULL,
	[AgeGroup] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	[Exposure] [nvarchar](255) NULL,
	[CaseStatus] [nvarchar](255) NULL,
	[Province] [nvarchar](255) NULL,
	[Status] int null
)
GO

CREATE TABLE [dbo].[OngoingOutbreaksPHU_Stage](
	[Date] [datetime] NULL,
	[PHUNum] [int] NULL,
	[OutbreakGroup] [nvarchar](255) NULL,
	[NumberOngoingOutbreaks] [int] NULL,
	[Status] int null
) 
GO

CREATE TABLE [dbo].[PublicHealthUnit_Stage](
	[PHUID] [int] NOT NULL PRIMARY KEY,
	[ReportingPHU] [nvarchar](255) NULL,
	[ReportingPHUAddress] [nvarchar](255) NULL,
	[ReportingPHUCity] [nvarchar](255) NULL,
	[ReportingPHUPostalCode] [nvarchar](255) NULL,
	[ReportingPHUWebsite] [nvarchar](255) NULL,
	[ReportingPHULatitude] [nvarchar](50) NULL,
	[ReportingPHULongitude] [nvarchar](50) NULL,
	[Status] int null
) 
GO

CREATE TABLE [dbo].[PublicHealthUnitsGroup_Stage](
	[PHUGroup] [nvarchar](255) NULL,
	[PHUCity] [nvarchar](255) NOT NULL PRIMARY KEY,
	[PHURegion] [nvarchar](255) NULL,
	[Status] int null
) 
GO

CREATE TABLE [dbo].[VaccinesByAgePHU_Stage](
	[Date] [datetime] NULL,
	[PHUID] [int] NULL,
	[AgeGroup] [nvarchar](255) NULL,
	[At_least_one_dose_cumulative] [int] NULL,
	[Second_dose_cumulative] [int] NULL,
	[fully_vaccinated_cumulative] [int] NULL,
	[third_dose_cumulative] [int] NULL,
	[Status] int null
) 
GO











