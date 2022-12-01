--USE master
--GO
--CREATE DATABASE [NDS]
--GO
USE [NDS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Drop:  Table [dbo].[Covid19Cases]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Covid19Cases]') AND type in (N'U'))
DROP TABLE [dbo].[Covid19Cases]
GO

/****** Drop:  Table [dbo].[CompileCovid19CaseDetailsCanada]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompileCovid19CaseDetailsCanada]') AND type in (N'U'))
DROP TABLE [dbo].[CompileCovid19CaseDetailsCanada]
GO **/

/****** Drop:  Table [dbo].[OngoingOutbreaksPHU]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OngoingOutbreaksPHU]') AND type in (N'U'))
DROP TABLE [dbo].[OngoingOutbreaksPHU]
GO

/****** Drop:  Table [dbo].[PublicHealthUnit]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublicHealthUnit]') AND type in (N'U'))
DROP TABLE [dbo].[PublicHealthUnit]
GO

/****** Drop:  Table [dbo].[PublicHealthUnitsGroup]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublicHealthUnitsGroup]') AND type in (N'U'))
DROP TABLE [dbo].[PublicHealthUnitsGroup]
GO

/****** Drop:  Table [dbo].[PublicHealthUnitsCity]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublicHealthUnitsCity]') AND type in (N'U'))
DROP TABLE [dbo].[PublicHealthUnitsCity]
GO

/****** Drop:  Table [dbo].[VaccinesByAgePHU]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VaccinesByAgePHU]') AND type in (N'U'))
DROP TABLE [dbo].[VaccinesByAgePHU]
GO

/****** Drop:  Table [dbo].[AgeGroup]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AgeGroup]') AND type in (N'U'))
DROP TABLE [dbo].[AgeGroup]
GO

/****** Drop:  Table [dbo].[CaseStatus]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CaseStatus]') AND type in (N'U'))
DROP TABLE [dbo].[CaseStatus]
GO

/****** Drop:  Table [dbo].[Exposure]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Exposure]') AND type in (N'U'))
DROP TABLE [dbo].[Exposure]
GO

/****** Drop:  Table [dbo].[Gender]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Gender]') AND type in (N'U'))
DROP TABLE [dbo].[Gender]
GO

/****** Drop:  Table [dbo].[DataSource]*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSource]') AND type in (N'U'))
DROP TABLE [dbo].[DataSource]
GO

/**
CREATE TABLE [dbo].[CasesReport](
	[ID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[CaseStatusID] [int] NULL, --[Outcome] [nvarchar](255) NULL,
	[PHU_ID] [int] NULL,
	[ExposureID] [int] NULL, --[CaseAcquisitionInfo] [nvarchar](255) NULL,
	[AgeID] [nvarchar](255) NULL, 
	[Gender] [nvarchar](255) NULL,
	--[ReportingPHU] [nvarchar](255) NULL,
	[SpecimenDate] [nvarchar](50) NULL,
	[CaseReportedDate] [nvarchar](50) NULL,
	--[PHUCity] [nvarchar](255) NULL,
	[TestReportedDate] [nvarchar](50) NULL,
	[AccurateEpisodeDt] [nvarchar](50) NULL,
	--[PHUAddress] [nvarchar](255) NULL,
	--[PHUWebsite] [nvarchar](255) NULL,
	[OutbreakRelated] [nvarchar](255) NULL,
	--[PHULatitude] [nvarchar](50) NULL,
	--[PHULongitude] [nvarchar](50) NULL,
	--[PHUPostalCode] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
)
GO

CREATE TABLE [dbo].[CompileCovid19CaseDetailsCanada](
	[ObjectId] [int] NOT NULL PRIMARY KEY,
	--[RowId] [int] NULL,
	[ExposureID] [int] NULL,
	[PHU_ID] [int] NULL,
	[CaseStatusID] [int] NULL,
	[AgeID] [int] NULL,
	[DateReported] [nvarchar](50) NULL,
	--[HealthRegion] [nvarchar](255) NULL,
	--[AgeGroup] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	--[Exposure] [nvarchar](255) NULL,
	--[CaseStatus] [nvarchar](255) NULL,
	[Province] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
)
GO
**/
CREATE TABLE [dbo].[Covid19Cases](
	[CaseID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY
,	[ObjectID] [int] NOT NULL
,	[AgeID] [int] NULL
,	[ExposureID] [int] NULL
,	[CaseStatus] [int] NULL
,	[PHU_ID] [int] NULL
,	[DateReported] [datetime] NULL --,	[CaseReportedDate] [datetime] NULL
,	[SpecimenDate] [datetime] NULL
,	[TestReportedDate] [datetime] NULL
,	[AccurateEpisodeDt] [datetime] NULL
,	[OutbreakRelated] [nvarchar](255) NULL
,	[Gender] [int] NULL
,	[Province] [nvarchar](255) NULL
,	[Status] [int] NULL
,	[CreatedDate] [datetime] NULL
,	[UpdatedDate] [datetime] NULL
,	[DataSource] [int] NOT NULL
)
GO

CREATE TABLE [dbo].[OngoingOutbreaksPHU](
	[ID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[PHU_ID] [int] NOT NULL,
	[Date] [datetime] NULL,
	--[PHUNum] [int] NULL,
	[OutbreakGroup] [nvarchar](255) NULL,
	[NumberOngoingOutbreaks] [int] NULL,
	[Status] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[PublicHealthUnit](
	[PHUID] [int] NOT NULL PRIMARY KEY,
	[CityID] [int] NULL,
	[ReportingPHU] [nvarchar](255) NULL, --PHURegion
	[ReportingPHUAddress] [nvarchar](255) NULL,
	--[ReportingPHUCity] [nvarchar](255) NULL,
	[ReportingPHUPostalCode] [nvarchar](255) NULL,
	[ReportingPHUWebsite] [nvarchar](255) NULL,
	[ReportingPHULatitude] [nvarchar](50) NULL,
	[ReportingPHULongitude] [nvarchar](50) NULL,
	[Status] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[VaccinesByAgePHU](
	[ID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[PHU_ID] [int] NULL, --[PHUID] [int] NULL,
	[AgeID] [int] NULL, --[AgeGroup] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[At_least_one_dose_cumulative] [nvarchar](255) NULL,
	[Second_dose_cumulative] [nvarchar](255) NULL,
	[fully_vaccinated_cumulative] [nvarchar](255) NULL,
	[third_dose_cumulative] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[PublicHealthUnitsGroup](
	[GroupID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[PHUGroup] [nvarchar](255) NOT NULL,
	[Status] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[PublicHealthUnitsCity](
	[CityID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[GroupID] [int] NOT NULL,
	[PHUCity] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[AgeGroup](
	[AgeID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[AgeGroup] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[CaseStatus](
	[CaseStatusID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[CaseStatusName] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[Exposure](
	[ExposureID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[ExposureName] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) 
GO

CREATE TABLE [dbo].[Gender](
	[GenderID] [int] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Gender] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
)
GO

CREATE TABLE [dbo].[DataSource](
	[DataSource] [int] NOT NULL PRIMARY KEY,
	[DataSourceName] [nvarchar](255) NOT NULL
)
GO

INSERT INTO [dbo].DataSource VALUES (1, 'Cases Report'), (2, 'Compile Covid-19 Case Details Canada')
GO

ALTER TABLE [dbo].[PublicHealthUnitsCity]
ADD CONSTRAINT [FK_City_Group] FOREIGN KEY ([GroupID]) 
  REFERENCES [dbo].[PublicHealthUnitsGroup] ([GroupID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[VaccinesByAgePHU]
ADD CONSTRAINT [FK_Vacc_Age] FOREIGN KEY ([AgeID]) 
  REFERENCES [dbo].[AgeGroup] ([AgeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[VaccinesByAgePHU]
ADD CONSTRAINT [FK_Vacc_PHU] FOREIGN KEY ([PHU_ID]) 
  REFERENCES [dbo].[PublicHealthUnit] ([PHUID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[OngoingOutbreaksPHU]
ADD CONSTRAINT [FK_Outbreaks_PHU] FOREIGN KEY ([PHU_ID]) 
  REFERENCES [dbo].[PublicHealthUnit] ([PHUID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[PublicHealthUnit]
ADD CONSTRAINT [FK_PHU_City] FOREIGN KEY ([CityID]) 
  REFERENCES [dbo].[PublicHealthUnitsCity] ([CityID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[Covid19Cases]
ADD CONSTRAINT [FK_CC_Age] FOREIGN KEY ([AgeID]) 
  REFERENCES [dbo].[AgeGroup] ([AgeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[Covid19Cases]
ADD CONSTRAINT [FK_CC_Exposure] FOREIGN KEY ([ExposureID]) 
  REFERENCES [dbo].[Exposure] ([ExposureID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[Covid19Cases]
ADD CONSTRAINT [FK_CC_CaseStatus] FOREIGN KEY ([CaseStatus]) 
  REFERENCES [dbo].[CaseStatus] ([CaseStatusID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[Covid19Cases]
ADD CONSTRAINT [FK_CC_Gender] FOREIGN KEY ([Gender]) 
  REFERENCES [dbo].[Gender] ([GenderID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[Covid19Cases]
ADD CONSTRAINT [FK_CC_PHU] FOREIGN KEY ([PHU_ID]) 
  REFERENCES [dbo].[PublicHealthUnit] ([PHUID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO







