CREATE DATABASE [METADATA]
GO

USE [METADATA]
GO

/****** Object:  Table [dbo].[Data_Flow]    Script Date: 11/23/2022 11:10:14 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Data_Flow]') AND type in (N'U'))
DROP TABLE [dbo].[Data_Flow]
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

USE [METADATA]
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


