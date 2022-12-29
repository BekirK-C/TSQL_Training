-- CREATE-ALTER-DROP KULLANIMI

CREATE DATABASE TEST
DROP DATABASE TEST
CREATE TABLE NAMES(ID INT IDENTITY(1,1), _NAME VARCHAR(20))
ALTER TABLE NAMES ADD PHONE VARCHAR(12)
ALTER TABLE NAMES DROP COLUMN PHONE
INSERT INTO NAMES (_NAME) VALUES ('BEKIR')
DROP TABLE NAMES



-- T-SQL DEGISKEN KULLANIMI

DECLARE @NUMBER  AS INTEGER,
		@NUMBER2 AS INTEGER, 
		@TOTAL   AS INTEGER
SELECT @NUMBER2 = 20, @NUMBER = 15
SET @TOTAL = @NUMBER + @NUMBER2
SELECT @NUMBER AS NUMBER1,@NUMBER2 AS NUMBER2, @TOTAL AS TOTAL

--TABLODAKI VERIYI DEGISKENE ATAMA
USE TEST
DECLARE @NAME AS VARCHAR(50), @PHONE AS VARCHAR(50)
SELECT @NAME = _NAME,@PHONE = PHONE FROM NAMES WHERE ID = 1
SELECT @NAME, @PHONE



-- STRING FUNCTIONS

--SUBSTRING
DECLARE @WORD AS VARCHAR(50) = 'HELLO WORLD'
SELECT SUBSTRING(@WORD, 1,5), SUBSTRING(@WORD, 6,10)

--LOWER-UPPER
DECLARE @WORD2 AS VARCHAR(50) = 'HeLLo WoRld'
SELECT LOWER(@WORD2), UPPER(@WORD2)

--STRING CONCAT
DECLARE @WORD1 AS VARCHAR(50) = 'HELLO'
DECLARE @WORD2 AS VARCHAR(50) = 'WORLD'
--SELECT @WORD1 + ' ' + @WORD2
SELECT CONCAT(@WORD1, ' ', @WORD2)

--RIGHT-LEFT
DECLARE @WORD AS VARCHAR(50) = 'HELLO WORLD'
SELECT LEFT(@WORD, 5), RIGHT(@WORD, 5)

--TRIM,RTRIM,LTRIM
DECLARE @WORD AS VARCHAR(50) = '  HELLO WORLD  '
SELECT LTRIM(@WORD),RTRIM(@WORD),TRIM(@WORD)

--REPLACE
DECLARE @WORD AS VARCHAR(50) = 'HELLO WORLT'
SELECT REPLACE(@WORD,'T','D')

--LEN
DECLARE @WORD AS VARCHAR(50) = 'HELLO WORLD'
SELECT LEN(@WORD)

--STRING SPLIT
DECLARE @WORD AS VARCHAR(50) = 'HELLO WORLD FROM JUPYTER'
SELECT * FROM strIng_splIt(@WORD, ' ')



-- DATETIME FUNCTIONS

--DATEADD
DECLARE @DATE AS DATETIME = '2023-01-01 01:00:00'
DECLARE @DATE2 AS DATETIME
SET @DATE2=DATEADD(MONTH, 6, @DATE)
SELECT @DATE, @DATE2

--DATEDIFF
DECLARE @DATE AS DATETIME = '2023-01-01 01:00:00'
DECLARE @DATE2 AS DATETIME = '2024-11-10 01:00:00'
SELECT DATEDIFF(HOUR,@DATE, @DATE2)

--DATEFROMPARTS
DECLARE @DATE AS DATETIME
SET @DATE = DATEFROMPARTS(2023,01,01)
SELECT @DATE

--DATEPART
DECLARE @DATE AS DATETIME = '2023-01-01 01:00:00'
SELECT DATEPART(YEAR,@DATE)
--SELECT YEAR(@DATE)

--GETDATE
DECLARE @DATE AS DATETIME = '2000-01-01 01:00:00'
SELECT DATEDIFF(YEAR,@DATE, GETDATE())



-- NAME VE SURNAME TABLOLARINDAN RASTGELE VERI ALARAK PEOPLE TABLOSU OLUSTURMAK

DECLARE @I AS INTEGER = 0,
		@FIRST_NAME AS VARCHAR(50),
		@LAST_NAME AS VARCHAR(50),
		@GENDER AS VARCHAR(50),
		@DATE_OF_BIRTH AS VARCHAR(50),
		@AGE AS VARCHAR(50),
		@AGE_GROUP AS VARCHAR(50),
WHILE @I < 1000
BEGIN
	SELECT @FIRST_NAME = FIRST_NAME, @GENDER = GENDER FROM NAMES WHERE ID = ROUND(RAND() * 500,0)
	SELECT,@LAST_NAME = LAST_NAME FROM SURNAMES WHERE ID = ROUND(RAND() * 500,0)
	SET @DATE_OF_BIRTH = ((DATEADD(DAY,ROUND(RAND()*21900,0),'1950-01-01')))
	SELECT @AGE = DATEDIFF(YEAR, @DATE_OF_BIRTH, GETDATE())

	IF @AGE BETWEEN 15 AND 30
	SET  @AGE_GROUP = 'YOUNG'
	IF @AGE BETWEEN 31 AND 55
	SET  @AGE_GROUP = 'MIDDLE AGE'
	IF @AGE > 55
	SET  @AGE_GROUP = 'OLD'

	INSERT INTO PEOPLE (FIRST_NAME, LAST_NAME, GENDER, DATE_OF_BIRTH, AGE, AGE_GROUP)
	VALUES (@FIRST_NAME, @LAST_NAME, @GENDER, @DATE_OF_BIRTH, @AGE, @AGE_GROUP)
SET @I = @I + 1
END