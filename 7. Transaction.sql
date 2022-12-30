-- TRAN ICERISINDE HATAYA KARSI ROLLBACK DONEN PARA AKTARIM ISLEMI OLUSTURMA
BEGIN TRAN
INSERT INTO MONEYTRANSACTIONS ([ACCOUNTID], [TRANTYPE], [AMOUNT], [DATE_], [CURRENCY], [EFTCODE1], [EFTCODE2])
VALUES (1, 2, 1000, GETDATE(), 'TL', '12345678', '')
IF @@ERROR > 0
BEGIN
	ROLLBACK TRAN
	RETURN
END

UPDATE ACCOUNTBALANCE SET BALANCE = BALANCE - 1000 WHERE ACCOUNTID = 1
IF @@ERROR > 0
BEGIN
	ROLLBACK TRAN
	RETURN
END

INSERT INTO MONEYTRANSACTIONS ([ACCOUNTID], [TRANTYPE], [AMOUNT], [DATE_], [CURRENCY], [EFTCODE1], [EFTCODE2])
VALUES (2, 1, 1000, GETDATE() + 0.04, 'TL', '12345678', '0987654321')
IF @@ERROR > 0
BEGIN
	ROLLBACK TRAN
	RETURN
END

UPDATE ACCOUNTBALANCE SET BALANCE = BALANCE + 1000 WHERE ACCOUNTID = 2
IF @@ERROR > 0
BEGIN
	ROLLBACK TRAN
	RETURN
END

COMMIT TRAN
-- TRAN ICERISINDE HATAYA KARSI ROLLBACK DONEN ISLEM OLUSTURMA

-- ISLEM KOTROLU
SELECT * FROM MONEYTRANSACTIONS WITH (NOLOCK)

-- (NOLOCK):
-- BIR TABLODA KAYIT UZERINDE YAPILAN ISLEM SONUCUNDA ISLEM SONLANANA KADAR SERVER SQL SERVER TARAFINDAN �LOCKING� EDILIR (KILITLENIR).
-- BU ISLEM SONLANANA KADAR BASKA BIR KULLANICININ BU TABLO UZERINDE ISLEM YAPILMASI ENGELLENIR.
-- VERI GETIRIRKEN LOCKING DURUMUNU ASMAK ICIN SQL SORGUSUNDA (NOLOCK) HINT'I KULLANILIR.



-- TRANSACTION:
-- TRANSACTION BIR VEYA DAHA FAZLA SQL IFADESINI BIR BUTUN OLARAK DUSUNEN VE BASARILI OLMASI HALINDE 
-- SQL IFADELERINI KALICI OLARAK ISTENILEN DEGISIKLIGI UYGULAYAN VEYA HATA OLMASI HALINDE DEGISIKLIK YAPMADAN 
-- VERILERI AYNI SEKILDE KORUNMASINI SAGLAYAN ISLEMDIR.