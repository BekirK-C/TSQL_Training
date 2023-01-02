DECLARE @NAMESURNAME AS VARCHAR(50) = ''
DECLARE @AGE AS INT
DECLARE @EMAIL AS VARCHAR(50) = ''
DECLARE @MSG AS VARCHAR(200) = ''

DECLARE CRS CURSOR FOR
	SELECT NAMESURNAME, DATEDIFF(YEAR, BIRTHDATE,GETDATE()) AS AGE, EMAIL FROM USERS
	WHERE DAY(BIRTHDATE) = 2 AND MONTH(BIRTHDATE) = 3
OPEN CRS
	FETCH NEXT FROM VRS INTO @NAMESURNAME, @AGE, @EMAIL, @MSG

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @MSG = 'SAYIN' + @NAMESURNAME + ', DOGUM GUNUNUZ KUTLU OLSUN.'+ CONVERT(VARCHAR,@AGE) + '. YASINIZI KUTLARIM.'

		EXEC dbo.sp_send_dbmail @profil_name = 'SQLMAIL',
		@SUBJECT = 'MUTLU YILLAR',
		@BODY = @MSG,
		@RESIPIENTS = @EMAIL
		FETCH NEXT FROM VRS INTO @NAMESURNAME, @AGE, @EMAIL, @MSG
	END
CLOSE CRS 
DEALLOCATE CRS

--CURSOR NEDIR:
--CURSORLAR, VERI K�MESINDEKI HER BIR VERIYI ADIM ADIM BIZLERE GETIREN VE BU SEKILDE SATIRSAL BAZDA ISLEM YAPMAMIZI SAGLAYAN YAPILARDIR.

--AVANTAJI:
--1.SORGU NETICESINDE ELDE EDILEN VERI K�MESINDE SATIR SATIR GEZINEREK ISLEM YAPMAK
--2.DIGER KULLANICILAR TARAFINDAN YAPILAN DEGISIKLIKLERIN G�R�N�RL�K SEVIYESINI AYARLAMAK