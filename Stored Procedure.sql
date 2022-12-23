		-- CREATING SP --
CREATE PROCEDURE SP_WORKER_INOUT
@WORKERBARCODE AS VARCHAR(50),
@DATE AS DATETIME,
@IOTYPE AS VARCHAR(1),
@GATEID AS INT
AS
BEGIN
DECLARE @WORKERNAME AS VARCHAR(100)
DECLARE @WORKERID AS INT
	SELECT @WORKERNAME = WORKERNAME, @WORKERID = ID FROM WORKERS WHERE WORKERBARCODE = @WORKERBARCODE
	IF  @WORKERNAME IS NULL
	BEGIN
		RAISERROR('KART GE�ERS�Z',16,1)
		RETURN
	END

DECLARE @LASTIO AS VARCHAR(1)

SELECT TOP 1 @LASTIO = IOTYPE FROM WORKERTRANSACTIONS
WHERE WORKERID = 1 AND DATE_ <= CONVERT(date,GETDATE())
ORDER BY DATE_ DESC

	IF @LASTIO = @IOTYPE
	BEGIN
		IF @IOTYPE = 'G'
		BEGIN
			RAISERROR('��ER�DES�N�Z TEKRAR G�R�� YAPAMAZSINIZ',16,1)
			RETURN
		END
		IF @IOTYPE = 'C'
		BEGIN
			RAISERROR('DI�ARIDASINIZ TEKRAR �IKI� YAPAMAZSINIZ',16,1)
			RETURN
		END
	END
INSERT INTO WORKERTRANSACTIONS (WORKERID, DATE_, IOTYPE, GATEID)
VALUES (@WORKERID, @DATE, @IOTYPE, @GATEID)

SELECT @WORKERNAME AS WORKERNAME, @DATE AS DATE_, @IOTYPE AS IOTYPE
END
		-- CREATING SP --


  -- USING SP --
EXEC SP_WORKER_INOUT
@WORKERBARCODE = '63355AC4-DB23-40EC-BA6A-2CBD00E6B7E6',
@DATE = '2022-12-23 12:10:15',
@IOTYPE = 'G',
@GATEID = 1
  -- USING SP --


					-- AD HOC QUERY (ANLIK SORGU) --
--YAZILAN SORGUNUN B�R AMA� ���N YAZILIP �O�UNLUKLA DEVAMININ OLMADI�I SORGULARDIR.
--AD HOC QUERY ��LEN�RKEN VER� TABANI SUNUCUSUNUN UYGULADI�I ADIMLAR
--1.QUERY
--2.PARSE
--3.OPTIMIZE
--4.COMPILE
--5.EXECUTE
--6.RESULT


				  -- STORED PROCEDURE (YAPISAL YORDAM) --
--HAZIRLAMI� OLDU�UMUZ T-SQL KODUNU KAYIT EDEB�LD���M�Z SQL KOMUTLARIDIR.
--EXECUTION PLAN �IKARILDI�I VE DERLEND��� ���N �LK 4 A�AMAYI ATLAR VE DAHA HIZLI �ALI�IR.
--5.EXECUTE
--6.RESULT

SELECT * FROM sys.dm_exec_procedure_stats


-- SP'LER # ET�KET�YLE OLU�TURACA�IMIZ GE��C� B�R TABLOYA INSERT ED�LEB�L�R. 
-- BU �EK�LDE M�DAHELE EDEMED���M�Z/YRETK�M�Z�Z OLMADI�I SP'LERDE ��LEM YAPAB�L�R�Z.