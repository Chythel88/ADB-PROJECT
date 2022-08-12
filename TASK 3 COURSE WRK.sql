USE master
    GO
    CREATE DATABASE CRIMEPROFILER
    GO


CREATE SCHEMA Profiler
GO

--USE UNION ALL TO JOIN ALL THE 24 MONTHS

SELECT * INTO Profiler.Crime FROM [dbo].['2017-01-greater-manchester-stre$']
UNION ALL 
SELECT * FROM [dbo].['2017-02-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2017-03-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2017-04-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2017-05-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2017-06-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2017-07-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2017-08-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2017-09-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2017-10-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2017-11-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2017-12-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2018-01-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2018-02-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2018-03-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2018-04-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2018-05-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2018-06-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2018-07-greater-manchester-stre$']
UNION ALL
SELECT *FROM [dbo].['2018-08-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2018-09-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2018-10-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2018-11-greater-manchester-stre$']
UNION ALL
SELECT * FROM [dbo].['2018-12-greater-manchester-stre$']


--ALTER TABLE TO ADD PRIMARY KEY TO All_Crime

ALTER TABLE[Profiler].[Crime] 
ADD ID INT IDENTITY;

ALTER TABLE [Profiler].[Crime]
ADD CONSTRAINT PK_ID PRIMARY KEY NONCLUSTERED(ID);
GO

ALTER TABLE [Profiler].[Crime]
ADD [GEOLOCATION] GEOGRAPHY

	UPDATE [Profiler].[Crime]
	SET [GEOLOCATION] = GEOGRAPHY::Point(Latitude, Longitude, 4326)
	WHERE [Longitude] IS NOT NULL
	AND [Latitude] IS NOT NULL
	AND CAST(Latitude AS decimal(10, 6)) BETWEEN -90 AND 90
	AND CAST(Longitude AS decimal(10, 6)) BETWEEN -90 AND 90

	SELECT p.*,m.*
	FROM [CRIMEPROFILER].[dbo].[LSOA] p
	INNER JOIN [CRIMEPROFILER].[Profiler].[Crime] m
	ON p.[LSOA Code]= m.[LSOA code]

	CREATE VIEW Profiler.Crimelsoa AS
	SELECT [Crime type],L.[LSOA name],[GEOLOCATION],[ID],[All Ages],P.[LSOA Code]
	FROM   [Profiler].[Crime]AS P
    INNER JOIN [dbo].[LSOA] AS L
    ON P.[LSOA Name] = L.[LSOA Name]
   
   SELECT * FROM [Profiler].[Crimelsoa]

	
--1.LSOA CRIME REPORTS-
	--QUE 1, The top 5 area in Wigan with highest occurence of robbery as a crime type
	CREATE VIEW Profiler.SKBurglary AS
	SELECT TOP 5 [lsoa name], [All ages], COUNT (ID) AS NUMBER
	FROM[Profiler].[Crimelsoa]	
	WHERE [Crime type] = 'Robbery' AND [LSOA name] LIKE 'Wigan%'
	GROUP BY [lsoa name], [All ages]
	ORDER BY NUMBER desc

	SELECT * FROM [Profiler].[SKBurglary]
	

--QUE 2. Compare the number of crime incidence of burglary and Shoplifting within Stockport and Oldham
	CREATE VIEW Profiler.CrimeSk AS
	SELECT [CRIME TYPE], COUNT([LSOA name]) AS Sk_NUMBER
	FROM[Profiler].[Crimelsoa]	
	WHERE ([Crime type] = 'BURGLARY' OR [Crime type] = 'SHOPLIFTING') AND [LSOA name] LIKE 'STOCKPORT%'
	GROUP BY [Crime type]

	CREATE VIEW Profiler.CrimeOL AS
	SELECT [CRIME TYPE], COUNT([LSOA name]) AS OL_Number
	FROM[Profiler].[Crimelsoa]	
	WHERE ([Crime type] = 'BURGLARY' OR [Crime type] = 'SHOPLIFTING')AND [LSOA name] LIKE 'Oldham%'
	GROUP BY [Crime type]

	CREATE VIEW Profiler.CrimeSKOL AS
	SELECT S.[CRIME TYPE], OL_NUMBER, SK_NUMBER FROM [Profiler].[CrimeSk] S
	INNER JOIN [Profiler].[CrimeOL] O
	ON S.[CRIME TYPE] = O.[CRIME TYPE]
	GROUP BY S.[CRIME TYPE], OL_NUMBER, SK_NUMBER

	
	SELECT * FROM [Profiler].[CrimeSKOL]

	
--ADDITIONAL Question 1
--Visualize Vehicle Crime in Manchester using QGIS

	CREATE VIEW Profiler.VehicleCrime
	WITH SCHEMABINDING
	AS
	SELECT m.[ID],m.[Geolocation],p.[All ages],p.[LSOA name]
	FROM [dbo].[LSOA] p
	INNER JOIN [Profiler].[Crime] m
	ON p.[LSOA Code]= m.[LSOA code]	
	WHERE [Crime type] = 'Vehicle crime'

--question2
--Visualize the Anti-social behiaviour crime in Salford

	CREATE VIEW Profiler.Antisocial
	WITH SCHEMABINDING
	AS
	SELECT m.[ID],m.[Geolocation],p.[All ages],p.[LSOA name]
	FROM [dbo].[LSOA] p
	INNER JOIN [Profiler].[Crime] m
	ON p.[LSOA Code]= m.[LSOA code]
	WHERE [Crime type] = 'Anti-social behaviour' AND p.[LSOA name] LIKE 'SALFORD%'

	CREATE UNIQUE CLUSTERED INDEX idx_id ON Profiler.Antisocial(ID)
    GO
    CREATE UNIQUE CLUSTERED INDEX idx_id ON Profiler.VehicleCrime(ID)










