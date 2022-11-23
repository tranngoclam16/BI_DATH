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
	[Outcome] [nvarchar](255) NULL,
	[Age] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	[ReportingPHU] [nvarchar](255) NULL,
	[SpecimenDate] [nvarchar](50) NULL,
	[CaseReportedDate] [nvarchar](50) NULL,
	[PHUCity] [nvarchar](255) NULL,
	[TestReportedDate] [nvarchar](50) NULL,
	[CaseAcquisitionInfo] [nvarchar](255) NULL,
	[AccurateEpisodeDt] [nvarchar](50) NULL,
	[PHUAddress] [nvarchar](255) NULL,
	[PHUWebsite] [nvarchar](255) NULL,
	[OutbreakRelated] [nvarchar](255) NULL,
	[PHULatitude] [nvarchar](50) NULL,
	[PHULongitude] [nvarchar](50) NULL,
	[PHUPostalCode] [nvarchar](255) NULL,
	[CreatedDate] [nvarchar](50) NULL,
	[UpdatedDate] [nvarchar](50) NULL
)
GO

CREATE TABLE [dbo].[CompileCovid19CaseDetailsCanada_Stage](
	[ObjectId] [nvarchar](50) NOT NULL PRIMARY KEY,
	[RowId] [nvarchar](50) NULL,
	[DateReported] [nvarchar](50) NULL,
	[HealthRegion] [nvarchar](255) NULL,
	[AgeGroup] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	[Exposure] [nvarchar](255) NULL,
	[CaseStatus] [nvarchar](255) NULL,
	[Province] [nvarchar](255) NULL,
	[CreatedDate] [nvarchar](50) NULL,
	[UpdatedDate] [nvarchar](50) NULL
)
GO

CREATE TABLE [dbo].[OngoingOutbreaksPHU_Stage](
	[Date] [nvarchar](50) NULL,
	[PHUNum] [nvarchar](50) NULL,
	[OutbreakGroup] [nvarchar](255) NULL,
	[NumberOngoingOutbreaks] [nvarchar](50) NULL,
	[CreatedDate] [nvarchar](50) NULL,
	[UpdatedDate] [nvarchar](50) NULL
) 
GO

CREATE TABLE [dbo].[PublicHealthUnit_Stage](
	[PHUID] [nvarchar](50) NOT NULL PRIMARY KEY,
	[ReportingPHU] [nvarchar](255) NULL,
	[ReportingPHUAddress] [nvarchar](255) NULL,
	[ReportingPHUCity] [nvarchar](255) NULL,
	[ReportingPHUPostalCode] [nvarchar](255) NULL,
	[ReportingPHUWebsite] [nvarchar](255) NULL,
	[ReportingPHULatitude] [nvarchar](50) NULL,
	[ReportingPHULongitude] [nvarchar](50) NULL,
	[CreatedDate] [nvarchar](50) NULL,
	[UpdatedDate] [nvarchar](50) NULL
) 
GO

CREATE TABLE [dbo].[PublicHealthUnitsGroup_Stage](
	[PHUGroup] [nvarchar](50) NULL,
	[PHUCity] [nvarchar](50) NOT NULL PRIMARY KEY,
	[PHURegion] [nvarchar](255) NULL,
	[CreatedDate] [nvarchar](50) NULL,
	[UpdatedDate] [nvarchar](50) NULL
) 
GO

CREATE TABLE [dbo].[VaccinesByAgePHU_Stage](
	[Date] [nvarchar](50) NULL,
	[PHUID] [nvarchar](50) NULL,
	[AgeGroup] [nvarchar](50) NULL,
	[At_least_one_dose_cumulative] [nvarchar](50) NULL,
	[Second_dose_cumulative] [nvarchar](50) NULL,
	[fully_vaccinated_cumulative] [nvarchar](50) NULL,
	[third_dose_cumulative] [nvarchar](50) NULL,
	[CreatedDate] [nvarchar](50) NULL,
	[UpdatedDate] [nvarchar](50) NULL
) 
GO











