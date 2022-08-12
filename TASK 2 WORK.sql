USE master
GO
CREATE DATABASE INEQUALITY
GO

CREATE SCHEMA Reporter
GO
--1. Reporter.Identifiers Table
CREATE TABLE [Reporter].[Identifiers](
       [UNIQUEID] VARCHAR(50) NOT NULL
      ,[SCHOOLID] VARCHAR(50) NOT NULL
      ,[CLASSID] VARCHAR(50) NOT NULL
      ,[STUDENTID] VARCHAR(50) NOT NULL
      ,[YLCHILDID] VARCHAR(50) NOT NULL
      ,[PROVINCE] VARCHAR(50) NOT NULL
      ,[DISTRICTCODE] VARCHAR(50) NOT NULL
      ,[LOCALITY] VARCHAR(50) NOT NULL
      ,[GENDER] VARCHAR(50) NOT NULL
      ,[AGE] VARCHAR(50) NOT NULL
      ,[ETHNICITY] VARCHAR(50) NOT NULL
	  ,[HTTYPSCH] VARCHAR(50) NOT NULL
	  PRIMARY KEY (UNIQUEID));
INSERT INTO [Reporter].[Identifiers]
SELECT [UNIQUEID] 
      ,[SCHOOLID] 
      ,[CLASSID] 
      ,[STUDENTID] 
      ,[YLCHILDID] 
      ,[PROVINCE] 
      ,[DISTRICTCODE] 
      ,[LOCALITY] 
      ,[GENDER] 
      ,[AGE] 
      ,[ETHNICITY] 
	  ,[HTTYPSCH] 
FROM [dbo].[Vietnam Wave 1]


--2.Reporter.Study_kits Table
--DROP TABLE [Reporter].[Study_Kits]

 
CREATE TABLE [Reporter].[Study_Kits](
       [UNIQUEID] VARCHAR(50) NOT NULL
       ,[STNMBOOK] VARCHAR(50) NOT NULL
      ,[STPLSTDY] VARCHAR(50) NOT NULL
      ,[STHVDESK] VARCHAR(50) NOT NULL
      ,[STHVCHR] VARCHAR(50) NOT NULL
      ,[STHVLAMP] VARCHAR(50) NOT NULL
      ,[STHVCOMP] VARCHAR(50) NOT NULL
      ,[STHVINTR] VARCHAR(50) NOT NULL
      ,[STITMOW1] VARCHAR(50) NOT NULL
      ,[STITMOW2] VARCHAR(50) NOT NULL
      ,[STITMOW3] VARCHAR(50) NOT NULL
      ,[STITMOW4] VARCHAR(50) NOT NULL
      ,[STITMOW5] VARCHAR(50) NOT NULL
      ,[STITMOW6] VARCHAR(50) NOT NULL
      ,[STITMOW7] VARCHAR(50) NOT NULL
      ,[STITMOW8] VARCHAR(50) NOT NULL
      ,[STBRWBK] VARCHAR(50) NOT NULL)
INSERT INTO [Reporter].[Study_Kits]
SELECT [UNIQUEID]
       ,[STNMBOOK]
      ,[STPLSTDY]
      ,[STHVDESK]
      ,[STHVCHR]
      ,[STHVLAMP]
      ,[STHVCOMP]
      ,[STHVINTR]
      ,[STITMOW1]
      ,[STITMOW2]
      ,[STITMOW3]
      ,[STITMOW4]
      ,[STITMOW5] 
      ,[STITMOW6]
      ,[STITMOW7]
      ,[STITMOW8]
      ,[STBRWBK]
	   FROM [dbo].[Vietnam Wave 1]

ALTER TABLE [Reporter].[Study_Kits]
ADD CONSTRAINT FK_Studykits
FOREIGN KEY (Uniqueid) REFERENCES [Reporter].[Identifiers];



 --3.Reporter.Learning_Atmosphere Table
-- DROP TABLE [Reporter].[Learning_Atmosphere]

 CREATE PROCEDURE Reporter.Proc_LA_monthly AS

 EXEC [Reporter].[Proc_LA_monthly]


 CREATE TABLE [Reporter].[Learning_Atmosphere](
       [UNIQUEID] VARCHAR(50) NOT NULL
      ,[SCAVLB1] VARCHAR(50) NOT NULL
      ,[SCAVLB2] VARCHAR(50) NOT NULL
      ,[SCAVLB3] VARCHAR(50) NOT NULL
      ,[SCAVLB4] VARCHAR(50) NOT NULL
      ,[SCAVLB5] VARCHAR(50) NOT NULL
      ,[SCAVLB6] VARCHAR(50) NOT NULL
      ,[SCAVLB7] VARCHAR(50) NOT NULL
      ,[SCAVLB8] VARCHAR(50) NOT NULL
      ,[SCAVLB9] VARCHAR(50) NOT NULL
      ,[SCAVLB10] VARCHAR(50) NOT NULL)
INSERT INTO [Reporter].[Learning_Atmosphere]
SELECT [UNIQUEID]
      ,[SCAVLB1] 
      ,[SCAVLB2] 
      ,[SCAVLB3] 
      ,[SCAVLB4] 
      ,[SCAVLB5] 
      ,[SCAVLB6]
      ,[SCAVLB7] 
      ,[SCAVLB8] 
      ,[SCAVLB9]
      ,[SCAVLB10] 
FROM [dbo].[Vietnam Wave 1]

DROP TABLE [Reporter].[Learning_Atmosphere]


ALTER TABLE [Reporter].[Learning_Atmosphere]
ADD CONSTRAINT FK_LearningAt
FOREIGN KEY (Uniqueid) REFERENCES [Reporter].[Identifiers];


--4.Reporter.Motivation Table

CREATE TABLE [Reporter].[Motivation](
       [UNIQUEID] VARCHAR(50) NOT NULL
      ,[STPLHL01] VARCHAR(50) NOT NULL
      ,[STPLHL02] VARCHAR(50) NOT NULL
      ,[STPLHL03] VARCHAR(50) NOT NULL
      ,[STPLHL04] VARCHAR(50) NOT NULL
      ,[STPLHL05] VARCHAR(50) NOT NULL
      ,[STPLHL06] VARCHAR(50) NOT NULL)
	INSERT INTO [Reporter].[Motivation]
	SELECT [UNIQUEID]
      ,[STPLHL01]
      ,[STPLHL02]
      ,[STPLHL03]
      ,[STPLHL04]
      ,[STPLHL05]
      ,[STPLHL06]
	  FROM [dbo].[Vietnam Wave 1]

ALTER TABLE [Reporter].[Motivation]
ADD CONSTRAINT FK_Motivation
FOREIGN KEY (Uniqueid) REFERENCES [Reporter].[Identifiers];




--	3 SQL STATEMENTS

--1.select to see the Number of these 4 basic resources available in learning environment for children in each province
SELECT PROVINCE, COUNT(PROVINCE) AS AVAILABLE
FROM [Reporter].[ID]
WHERE SCAVLB3 = 'YES' and SCAVLB4 = 'YES' AND SCAVLB5 ='yes' AND SCAVLB6 ='YES'
GROUP BY [PROVINCE]



--2.Count the number of children that get the needed motivations from their parents to study for each province
SELECT STPLHL01, COUNT(CASE PROVINCE WHEN 'BEN TRE' THEN 1 END) AS 'BEN TRE', COUNT(CASE PROVINCE WHEN 'DA NANG' THEN 2 END) AS 'DA NANG',
COUNT(CASE PROVINCE WHEN 'HUNG YEN' THEN 3 END) AS 'HUNG YEN', COUNT(CASE PROVINCE WHEN 'LAO CAI' THEN 4 END) AS 'LAO CAI',
COUNT(CASE PROVINCE WHEN 'PHU YEN' THEN 5 END) AS 'PHU YEN'
FROM [Reporter].[ID]
WHERE STPLHL01 NOT LIKE ''
GROUP BY STPLHL01

--3.Count the availability of resources to study for children in each locality
SELECT LOCALITY, COUNT(CASE STHVCHR WHEN 'YES' THEN 1 END) AS 'STHVCHR', COUNT(CASE STHVDESK WHEN 'YES' THEN 1 END) AS 'STHVDESK',
COUNT(CASE STHVLAMP WHEN 'YES' THEN 1 END) AS 'STHVLAMP', COUNT(CASE STHVCOMP WHEN 'YES' THEN 1 END) AS 'STHVCOMP'
FROM [Reporter].[ID]
WHERE LOCALITY NOT LIKE ''
GROUP BY LOCALITY
   

--CREATE VIEW FOR THE 3 STATEMENTS ABOVE FOR VISUALISATION USING EXCEL


CREATE VIEW Reporter.ID AS

SELECT [SCAVLB3] =
CASE WHEN SCAVLB3 = 0 THEN 'NO'
     WHEN SCAVLB3 = 1 THEN 'YES'
	 END,
        [SCAVLB4] =
CASE WHEN SCAVLB4 = 0 THEN 'NO'
     WHEN SCAVLB4 = 1 THEN 'YES'
	 END,
	     [SCAVLB5] =
 CASE WHEN SCAVLB5 = 0 THEN 'NO'
     WHEN SCAVLB5 = 1 THEN 'YES'
	 END,
	     [SCAVLB6] =
CASE WHEN SCAVLB6 = 0 THEN 'NO'
     WHEN SCAVLB6 = 1 THEN 'YES'
	 END,
	     [SCAVLB10] =
CASE WHEN SCAVLB10 = 0 THEN 'NO'
     WHEN SCAVLB10 = 2 THEN 'YES'
	 END,
	      [STPLHL01] =
CASE WHEN STPLHL01 = 1 THEN 'Never or almost never'
      WHEN STPLHL01 = 2 THEN 'Once or twice a month'
      WHEN STPLHL01 = 3 THEN 'Once or twice a week'
      WHEN STPLHL01 = 4 THEN 'Every day or almost every day'
	  END,
         [HTTYPSCH] =
CASE WHEN HTTYPSCH = 1 THEN 'GOVERNMENT'
     WHEN HTTYPSCH = 2 THEN 'PRIVATE'
	 WHEN HTTYPSCH = 3 THEN 'OTHERS'
	 END,
	         [STHVCHR] =
CASE WHEN STHVCHR = 0 THEN 'NO'
     WHEN STHVCHR = 1 THEN 'YES'
	 END,
	         [STHVDESK] =
CASE WHEN STHVDESK = 0 THEN 'NO'
     WHEN STHVDESK = 1 THEN 'YES'
	 END,
	         [STHVLAMP] =
CASE WHEN STHVLAMP = 0 THEN 'NO'
     WHEN STHVLAMP = 1 THEN 'YES'
	 END,
	         [STHVCOMP] =
CASE WHEN STHVCOMP = 0 THEN 'NO'
     WHEN STHVCOMP = 1 THEN 'YES'
	 END,
         [GENDER] =
 CASE WHEN GENDER = 1 THEN 'MALE'
     WHEN GENDER = 2 THEN 'FEMALE'
	 END,
         [PROVINCE]=
 CASE WHEN PROVINCE = 1 THEN 'BEN TRE'
    WHEN PROVINCE = 2 THEN 'DA NANG'
    WHEN PROVINCE = 3 THEN 'HUNG YEN'
    WHEN PROVINCE = 4 THEN 'LAO CAI'
    WHEN PROVINCE = 5 THEN 'PHU YEN'
	END,
         [LOCALITY]=
CASE WHEN LOCALITY = 1 THEN 'RURAL'
	WHEN LOCALITY = 2 THEN 'URBAN'
	END
FROM [Reporter].[Identifiers] AS I
INNER JOIN [Reporter].[Learning_Atmosphere] AS L
ON I.UNIQUEID = L.UNIQUEID 
INNER JOIN [Reporter].[Motivation] AS M
ON I.UNIQUEID = M.UNIQUEID 
INNER JOIN [Reporter].[Study_Kits] AS S
ON I.UNIQUEID = S.UNIQUEID


SELECT * FROM [Reporter].[ID]


