--CREATING THE SUM FUNC
USE NorthwInd
GO
CREATE FUNCTION DBO.SUM(@NUMBER1 AS INT, @NUMBER2 AS INT)
RETURNS INT
AS
BEGIN
	DECLARE @RESULT AS INT
	SET @RESULT = @NUMBER1 + @NUMBER2
	RETURN @RESULT
END
--CREATING THE SUM FUNC


--USING
USE NorthwInd
GO
SELECT dbo.SUM(20,30)
--USING


------------------------------------------------------------------------------------------------


--CREATING THE AGE CALCULATOR FUNC
USE NorthwInd
GO
CREATE FUNCTION DBO.CALCULATE_AGE(@BIRTHDATE AS DATE)
RETURNS INT
AS BEGIN
DECLARE @RESULT AS INT
SET @RESULT = DATEDIFF(YEAR,@BIRTHDATE,GETDATE())
RETURN @RESULT
END
--CREATING THE AGE CALCULATOR FUNC


--USING
USE NorthwInd
GO
SELECT dbo.CALCULATE_AGE('19900101')
--USING


------------------------------------------------------------------------------------------------


--CREATING THE PRICE FUNC
USE ETrade2
GO
CREATE FUNCTION DBO.GET_ITEM_PRICE(@ITEMID AS INT, @PRICETYPE AS VARCHAR(10))
RETURNS FLOAT
AS
BEGIN
	DECLARE @RESULT AS FLOAT
	IF @PRICETYPE = 'MIN'
	BEGIN
		SELECT @RESULT = MIN(UNITPRICE) FROM ORDERDETAILS OD WHERE OD.ITEMID = @ITEMID
	END
	RETURN @RESULT
END
--CREATING THE PRICE FUNC


--USING
USE ETrade2
GO
SELECT ITM.ID, ITM.ITEMCODE AS MALZEME_KODU, ITM.ITEMNAME AS MALZEME_ADI,
	DBO.GET_ITEM_PRICE(ITM.ID,'MIN') AS EN_DUSUK_FIYAT
	DBO.GET_ITEM_PRICE(ITM.ID,'MAX') AS EN_DUSUK_FIYAT
	DBO.GET_ITEM_PRICE(ITM.ID,'AVG') AS EN_DUSUK_FIYAT
FROM ITEM AS ITM
--USING
--FONKSIYONLAR SORGUMUZU YAVASLATIR. BUNUN ONUNE GECMEK I�IN INDEX KULLANILIR.


------------------------------------------------------------------------------------------------


						-- TABLE VALUED FUNCTIONS  --
--BIR DEGER YERINE BIR TABLO (SATIRI) DONDUREN FONKSIYONLARDIR.

--CREATING THE INFO FUNC
USE ETrade2
GO
CREATE FUNCTION DBO.GET_ITEM_INFO(@ITEMID INT)
RETURNS TABLE
AS
RETURN 
(
SELECT 
	MIN(UNITPRICE) AS MINPRICE,
	MAX(UNITPRICE) AS MAXPRICE,
	AVG(UNITPRICE) AS AVGPRICE
FROM ORDERDETAILS WHERE ITEMID=@IDEMID
)
--CREATING THE INFO FUNC


--USING
USE ETrade2
GO
SELECT * FROM DBO.GET_ITEM_INFO(3)
--USING