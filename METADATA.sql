--USE master
--GO
--CREATE DATABASE [METADATA]
--GO

USE [METADATA]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Data_Flow]') AND type in (N'U'))
DROP TABLE [dbo].[Data_Flow]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DDS]') AND type in (N'U'))
DROP TABLE [dbo].[DDS]
GO

/****** Object:  Table [dbo].[Data_Flow]    Script Date: 11/23/2022 11:10:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Data_Flow](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenBang] [varchar](50) NULL,
	[LSET] [datetime] NULL,
 CONSTRAINT [PK_Data_Flow] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[DDS]    Script Date: 12/1/2022 9:13:27 PM ******/

CREATE TABLE [dbo].[DDS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenBang] [varchar](50) NULL,
	[LSET] [datetime] NULL,
 CONSTRAINT [PK_DDS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [dbo].[Data_Flow]
           (TenBang, LSET)
     VALUES
           ('CasesReport', '1990-01-01'),
		   ('CompileCovid19CaseDetailsCanada', '1990-01-01'),
		   ('OngoingOutbreaksPHU', '1990-01-01'),
		   ('PublicHealthUnit', '1990-01-01'),
		   ('PublicHealthUnitsGroup', '1990-01-01'),
		   ('VaccinesByAgePHU', '1990-01-01')
GO

INSERT INTO [dbo].[DDS]
           (TenBang, LSET)
     VALUES
           ('DimPHU', '1990-01-01'),
		   ('DimDate', '1990-01-01'),
		   ('DimGender', '1990-01-01'),
		   ('DimExposure', '1990-01-01'),
		   ('DimAge', '1990-01-01'),
		   ('DimOutcome', '1990-01-01'),
		   ('DimSeverity', '1990-01-01'),
		   ('FactCaseDetail', '1990-01-01'),
		   ('FactVaccineDetail', '1990-01-01')
GO