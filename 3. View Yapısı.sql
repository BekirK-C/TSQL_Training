CREATE VIEW VW_PRODUCTS
AS
SELECT P.ProductName AS [�R�N ADI],C.CategoryName AS [KATEGORI ADI], S.CompanyName [SIRKET ADI]FROM Products AS P
JOIN CategorIes AS C ON C.CategoryID = P.CategoryID
JOIN SupplIers  AS S ON S.SupplIerID = P.SupplIerID



SELECT * FROM VWPRODUCTS WHERE [�R�N ADI] = 'ChaI'

--VIEW, ICERIGI SORGU ILE BELIRLENEN SANAL BIR TABLODUR.
--VERI TABANINDA FAZLADAN YER KAPLAMAZ.
--GENELDE BIRDEN FAZLA TABLO �ZERINDE YAPILAN KARMASIK SORGULAR ICIN KULLANILIR.



SELECT * FROM INFORMATION_SCHEMA.COLUMNS --WHERE COLUMN_NAME='SupplIerID'
--BU SORGU ILE TABLO KOLONLARI HAKKINDAKI TUM BILGILERI ELDE EDEBILIRIZ.