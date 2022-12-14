
CREATE SCHEMA Monitor
GO



--DROP VIEW [dbo].[Echild_Info] to enable me add coulmn typesite and region which i need in my monitor.childinfo table

CREATE VIEW Echild_Info AS

SELECT TOP 1000 [childid]
      ,[yc]
      ,[round]
      ,[inround]
      ,[panel]
      ,[deceased]
      ,[childloc]
      ,[chsex]
      ,[chlang]
      ,[chethnic]
      ,[chldrel]
      ,[agemon]
      ,[birth]
      ,[birth_age]
	  ,[marrcohab]
	  ,[marrcohab_age]
      ,[chweight]
      ,[chheight]
	  ,[typesite]
	  ,[region]
      
  FROM [younglives].[dbo].[Ethiopia]

--Step 2, Use Union All to join the 3 views of the 3 diff countries and create a view using the schema name(Monitor) I already created


--DROP VIEW [Monitor].[Consolidated_ChildInfo]

  CREATE VIEW Monitor.Consolidated_ChildInfo AS

  SELECT * FROM [dbo].[Echild_Info]
  UNION ALL
  SELECT * FROM [dbo].[Ichild_Info]
  UNION ALL SELECT * FROM [dbo].[Vchild_Info];

--Step 3: Select all to ensure that the view created has all the information relating to childinfo for the 3 countries

  SELECT *
  FROM [Monitor].[Consolidated_ChildInfo]

--DROP TABLE [Monitor].[Child_Info]

--1.MONITOR.CHILDINFO TABLE
 SELECT *
 INTO  Monitor.Child_Info
 FROM Monitor.Consolidated_ChildInfo;

-- To assign primary key, the column must be not null

 ALTER TABLE [Monitor].[Child_Info]
 ALTER COLUMN [Childid] varchar(50)
 NOT NULL

 ALTER TABLE [Monitor].[Child_Info]
 ALTER COLUMN [round] varchar(50)
 NOT NULL

 ALTER TABLE [Monitor].[Child_Info]
 ADD CONSTRAINT PK_ChildInfo PRIMARY KEY CLUSTERED
 (Childid, round asc);


 --TABLE 2

 CREATE VIEW Vchild_Bodyattr AS

 SELECT TOP 1000 [childid]
      ,[round]
      ,[chweight]
      ,[chheight]
      ,[bmi]
      ,[zwfa]
      ,[zhfa]
      ,[zbfa]
      ,[zwfl]
      ,[fwfl]
      ,[fhfa]
      ,[fwfa]
      ,[fbfa]
      ,[underweight]
      ,[stunting]
      ,[thinness]
      ,[bwght]
      ,[bwdoc]
      
  FROM [dbo].[Vietnam]

  CREATE VIEW Monitor.Consolidated_ChildBodyattr AS

  SELECT * FROM [dbo].[Echild_Bodyattr]
  UNION ALL
  SELECT * FROM [dbo].[Ichild_Bodyattr]
  UNION ALL SELECT * FROM [dbo].[Vchild_Bodyattr];


  SELECT *
  FROM[Monitor].[Consolidated_ChildBodyattr]

--DROP TABLE [Monitor].[Child_Bodyattributes]

--CREATE PROCEDURE MONITOR.Childbody

--2.MONITOR.CHILD_BODYATTRIBUTES TABLE

 SELECT *
 INTO  Monitor.Child_Bodyattributes
 FROM Monitor.Consolidated_ChildBodyattr;

-- CREATION OF FK FOR 2ND TABLE
--Make the FK to be of the same length with PK
 ALTER TABLE [Monitor].[Child_Bodyattributes]
 ALTER COLUMN [Childid] varchar(50)


 ALTER TABLE [Monitor].[Child_Bodyattributes]
 ADD CONSTRAINT FK_Childbody 
 FOREIGN KEY (Childid, round) REFERENCES [Monitor].[Child_Info];

-- TABLE 3

 CREATE VIEW Vchild_Medical_Status AS

 SELECT TOP 1000 [childid]
      ,[round]   
      ,[bcg]
      ,[measles]
      ,[dpt]
      ,[polio]
      ,[hib]
      ,[chmightdie]
      ,[chillness]
      ,[chinjury]
      ,[chhprob]
      ,[chdisability]
      ,[chdisscale]
      ,[chsmoke]
      ,[chalcohol]
      ,[chrephealth1]
      ,[chrephealth2]
      ,[chrephealth3]
      ,[chrephealth4]
      ,[chhrel]
      ,[chhealth]
      ,[cladder]
      
  FROM [younglives].[dbo].[Vietnam]

  CREATE VIEW Monitor.Consolidated_ChildMedSta AS

  SELECT * FROM [dbo].[Echild_Medical_Status]
  UNION ALL
  SELECT * FROM [dbo].[Ichild_Medical_Status]
  UNION ALL SELECT * FROM [dbo].[Vchild_Medical_Status];


  SELECT *
  FROM[Monitor].[Consolidated_ChildMedSta]

--DROP TABLE [Monitor].[Child_Medical_Status]

--3.MONITOR.CHILD_MEDICAL STATUS TABLE
 SELECT *
 INTO  Monitor.Child_Medical_Status
 FROM Monitor.Consolidated_ChildMedSta;
 --CREATION OF FK FOR 3RD TABLE
 ALTER TABLE [Monitor].[Child_Medical_Status]
 ALTER COLUMN [Childid] varchar(50)

 ALTER TABLE [Monitor].[Child_Medical_Status]
 ADD CONSTRAINT FK_ChildMedical 
 FOREIGN KEY (Childid, round) REFERENCES[Monitor].[Child_Info];

 --TABLE 4

 CREATE VIEW Vchild_Literacy_Status AS

 SELECT TOP 1000 [childid]      
      ,[round]
      ,[hschool]
      ,[hstudy]
      ,[commsch]
      ,[preprim]
      ,[agegr1]
      ,[enrol]
      ,[engrade]
      ,[entype]
      ,[hghgrade]
      ,[timesch]
      ,[levlread]
      ,[levlwrit]
      ,[literate]
      
      
  FROM [younglives].[dbo].[Vietnam]

  CREATE VIEW Monitor.Consolidated_ChildLitSta AS

  SELECT * FROM [dbo].[Echild_Literacy_Status]
  UNION ALL
  SELECT * FROM [dbo].[Ichild_Literacy_Status]
  UNION ALL SELECT * FROM [dbo].[Vchild_Literacy_Status];


  SELECT *
  FROM  [Monitor].[Consolidated_ChildLitSta]

--DROP TABLE [Monitor].[Child_Literacy_Status]

--4.MONITOR.CHILD_LITERACY_STATUS TABLE
 SELECT *
 INTO  Monitor.Child_Literacy_Status
 FROM Monitor.Consolidated_ChildLitSta;
 --CREATION OF FK FOR 4TH TABLE
 ALTER TABLE [Monitor].[Child_Literacy_Status]
 ALTER COLUMN [Childid] varchar(50)

 ALTER TABLE [Monitor].[Child_Literacy_Status]
 ADD CONSTRAINT FK_ChildLiteracy 
 FOREIGN KEY (Childid, round) REFERENCES[Monitor].[Child_Info];

-- TABLE 5

 CREATE VIEW Vchild_FamilyInfo AS

 SELECT TOP 1000 [childid]
      ,[round]    
      ,[numante]
      ,[delivery]
      ,[tetanus]     
      ,[careid]
      ,[caredu]
      ,[carehead]
      ,[careage]
      ,[caresex]
      ,[carerel]
      ,[carecantread]
      ,[careladder]
      ,[careldr4yrs]
      ,[dadid]
      ,[dadedu]
      ,[dadlive]
      ,[dadage]
      ,[dadcantread]
      ,[dadyrdied]
      ,[momid]
      ,[momedu]
      ,[momlive]
      ,[momage]
      ,[momcantread]
      ,[momyrdied]
      
  FROM [younglives].[dbo].[Vietnam]

  CREATE VIEW Monitor.Consolidated_ChildFamInfo AS

  SELECT * FROM [dbo].[Echild_FamilyInfo]
  UNION ALL
  SELECT * FROM [dbo].[Ichild_FamilyInfo]
  UNION ALL SELECT * FROM [dbo].[Vchild_FamilyInfo];


  SELECT *
  FROM  [Monitor].[Consolidated_ChildFamInfo]

--DROP TABLE [Monitor].[Child_FamilyInfo]

--5.MONITOR.CHILD_FAMILYINFO TABLE
 SELECT *
 INTO  Monitor.Child_FamilyInfo
 FROM Monitor.Consolidated_ChildFamInfo;

 --CREATION OF FK FOR 5TH TABLE
 ALTER TABLE [Monitor].[Child_FamilyInfo]
 ALTER COLUMN [Childid] varchar(50)

 ALTER TABLE [Monitor].[Child_FamilyInfo]
 ADD CONSTRAINT FK_ChildFamInfo 
 FOREIGN KEY (Childid, round) REFERENCES[Monitor].[Child_Info];

 --TABLE 6

 CREATE VIEW Vchild_Family_Assets AS

 SELECT TOP 1000 [childid]
      ,[round]
      ,[aniany]
      ,[animilk]
      ,[anidrau]
      ,[anirumi]
      ,[anicowm]
      ,[anicowt]
      ,[anicalv]
      ,[anibufm]
      ,[anibuft]
      ,[anibull]
      ,[anihebu]
      ,[anidonk]
      ,[anishee]
      ,[anigoat]
      ,[anipigs]
      ,[anipoul]
      ,[anirabb]
      ,[aniothr]
      ,[ownlandhse]
      ,[ownhouse]
    
  FROM [younglives].[dbo].[Vietnam]

  CREATE VIEW Monitor.Consolidated_ChildFamAssets AS

  SELECT * FROM [dbo].[Echild_Family_Assets]
  UNION ALL
  SELECT * FROM  [dbo].[Ichild_Family_Assets]
  UNION ALL
  SELECT * FROM [dbo].[Vchild_Family_Assets];


  SELECT *
  FROM  [Monitor].[Consolidated_ChildFamAssets]

--DROP TABLE [Monitor].[Child_FamilyAssets]

--6.MONITOR.CHILD_FAMILYASSETS TABLE
 SELECT *
 INTO  Monitor.Child_FamilyAssets
 FROM Monitor.Consolidated_ChildFamAssets;

 --CREATION OF FK FOR 6TH TABLE
 ALTER TABLE [Monitor].[Child_FamilyAssets]
 ALTER COLUMN [Childid] varchar(50)

 ALTER TABLE [Monitor].[Child_FamilyAssets]
 ADD CONSTRAINT FK_ChildFamAssets
 FOREIGN KEY (Childid, round) REFERENCES[Monitor].[Child_Info];


-- TABLE 7

 ALTER TABLE [dbo].[India]
  
 RENAME COLUMN [wi] TO wi_new,
              [hq] TO hq_new,
		[sv] TO sv_new,
		[cd] TO cd_new,
		[drwaterq] TO drwaterq_new,
		[toiletq] TO toiletq_new,
		[elecq] TO electq_new,
		[cookingq]TO cookingq_new;


 CREATE VIEW Ichild_BasicAmenities AS

 SELECT TOP 1000 [childid]
      ,[round]			
      ,[wi_new] 
      ,[hq_new] 
      ,[sv_new] 
      ,[cd_new]
      ,[drwaterq_new]
      ,[toiletq_new]
      ,[elecq_new]
      ,[cookingq_new]
      
  FROM [younglives].[dbo].[India]

  CREATE VIEW Monitor.Consolidated_ChildBasicAmenities AS

  SELECT * FROM [dbo].[Echild_BasicAmenities]
  UNION ALL
  SELECT * FROM [dbo].[Ichild_BasicAmenities]
  UNION ALL
  SELECT * FROM [dbo].[Vchild_BasicAmenities];

--DROP TABLE [Monitor].[Child_BasicAmenities]

--7.MONITOR.CHILD_BASICAMENITIES TABLE
 SELECT *
 INTO  Monitor.Child_BasicAmenities
 FROM Monitor.Consolidated_ChildBasicAmenities;

 --CREATION OF FK FOR 7TH TABLE
 ALTER TABLE [Monitor].[Child_BasicAmenities]
 ALTER COLUMN [Childid] varchar(50)

 ALTER TABLE [Monitor].[Child_BasicAmenities]
 ADD CONSTRAINT FK_ChildBasicAmen
 FOREIGN KEY (Childid, round) REFERENCES[Monitor].[Child_Info];

 --5 SQL STATEMENTS
      

--1.COUNT NO PARENTS WHO ARE UNIVERSITY GRADUATES AND WERE ABLE TO ENROLL THEIR CHILDREN IN SCHOOL IN ROUND 5
SELECT COUNT(F.childid) AS Number
FROM [Monitor].[Child_FamilyInfo] AS F
LEFT JOIN [Monitor].[Child_Literacy_Status] AS L
ON F.childid = L.childid
WHERE dadedu >= '14' AND momedu >= '14' AND caredu >= '14' AND F.[round] = '5' AND L.[round] = '5'

CREATE PROCEDURE Monitor.Parents_Edu AS
EXEC [Monitor].[Parents_Edu]


--2.Count number of Children in each typesite who dropped out of school because of 
--loss of parents at tender age where tender age is 3yrs and above.

CREATE VIEW Monitor.Parents_died AS

SELECT typesite, (COUNT (ci.childid)) AS Number,
CASE WHEN [typesite]  = '1' THEN 'URBAN'
ELSE 'RURAL'
END AS Newtypesite
FROM [Monitor].[Child_FamilyInfo] AS CF
INNER JOIN [Monitor].[Child_Info] AS CI
ON CF.childid = CI.childid
WHERE agemon  >= '36' AND (dadlive = '3' OR momlive = '3')
GROUP BY typesite

SELECT * FROM [Monitor].[Parents_died]


--3 Select how many children that have access to at least 4 basic amenities in rural areas and urban areas
--against those that don't have.

CREATE VIEW Monitor.Rural AS
SELECT I.[round], COUNT (I.childid) AS Rural
FROM [Monitor].[Child_BasicAmenities] AS B
LEFT JOIN [Monitor].[Child_Info] AS I
ON B.childid = I.childid
WHERE (drwaterq_new = 1) AND (toiletq_new = 1) AND (elecq_new = 1) AND (cookingq_new = 1) AND (typesite = 2)
GROUP BY I.[round]

CREATE VIEW Monitor.Urban AS
SELECT I.[round], COUNT (I.childid) AS Urban
FROM [Monitor].[Child_BasicAmenities] AS B
LEFT JOIN [Monitor].[Child_Info] AS I
ON B.childid = I.childid
WHERE (drwaterq_new = 1) AND (toiletq_new = 1) AND (elecq_new = 1) AND (cookingq_new = 1) AND (typesite = 1)
GROUP BY I.[round]

SELECT I.[round] FROM [Monitor].[Urban] 
LEFT JOIN [Monitor].[Rural]
ON I.[round]



--4 Count number of young live children that got BCG vaccination in each country and those that did not.
CREATE VIEW Monitor.VietnamBCG AS
SELECT (count (childid)) AS VIETNAM
,CASE WHEN [bcg] = '0' THEN 'NO'
WHEN [bcg] = '1' THEN 'Yes'
END AS GivenBCG
FROM [Monitor].[Child_Medical_Status]
WHERE ([bcg] NOT LIKE '') AND (CHILDID LIKE 'VN%')
GROUP BY bcg

CREATE VIEW Monitor.EthiopiaBCG AS
SELECT (count (childid)) AS ETHIOPIA
,CASE WHEN [bcg] = '0' THEN 'NO'
WHEN [bcg] = '1' THEN 'Yes'
END AS GivenBCG
FROM [Monitor].[Child_Medical_Status]
WHERE ([bcg] NOT LIKE '') AND (CHILDID LIKE 'ET%')
GROUP BY BCG

CREATE VIEW Monitor.IndiaBCG AS
SELECT (count (childid)) AS INDIA
,CASE WHEN [bcg] = '0' THEN 'NO'
WHEN [bcg] = '1' THEN 'Yes'
END AS GivenBCG
FROM [Monitor].[Child_Medical_Status]
WHERE ([bcg] NOT LIKE '') AND (CHILDID LIKE 'IN%')
GROUP BY BCG

CREATE VIEW MONITOR.BCG AS
SELECT V.GIVENBCG, INDIA, VIETNAM, ETHIOPIA FROM [Monitor].[VietnamBCG] V
LEFT JOIN [Monitor].[EthiopiaBCG] E
ON E.[GivenBCG] = V.[GivenBCG]
LEFT JOIN [Monitor].[IndiaBCG] I
ON I.[GivenBCG] = V.[GivenBCG]
GROUP BY V.GIVENBCG, INDIA, VIETNAM, ETHIOPIA

SELECT * FROM [Monitor].[BCG]

--5. Select count to show number of children with any severly malnurished bodyattribute in all the rounds
CREATE VIEW Monitor.IndiaBA AS
SELECT [ROUND], COUNT (childid) AS India
FROM [Monitor].[Child_Bodyattributes]
WHERE (underweight = '2' OR stunting = '2' OR thinness = '2') AND (childid like 'IN%')
GROUP BY [ROUND]

CREATE VIEW Monitor.VietnamBA AS
SELECT [ROUND], COUNT (childid) AS Vietnam
FROM [Monitor].[Child_Bodyattributes]
WHERE (underweight = '2' OR stunting = '2' OR thinness = '2') AND (childid like 'VN%')
GROUP BY [ROUND]


CREATE VIEW Monitor.EthiopiaBA AS
SELECT [ROUND], COUNT (childid) AS Ethiopia
FROM [Monitor].[Child_Bodyattributes]
WHERE (underweight = '2' OR stunting = '2' OR thinness = '2')AND (childid like 'ET%')
GROUP BY [ROUND]

CREATE VIEW Monitor.BA AS 
SELECT I.[ROUND],INDIA, VIETNAM, ETHIOPIA FROM [Monitor].[IndiaBA] I
LEFT JOIN [Monitor].[VietnamBA] V
ON I.[ROUND] = V.[ROUND]
LEFT JOIN [Monitor].[EthiopiaBA] E
ON I.[ROUND] = E.[ROUND]
GROUP BY I.[ROUND],INDIA, VIETNAM, ETHIOPIA

SELECT * FROM [Monitor].[BA]
