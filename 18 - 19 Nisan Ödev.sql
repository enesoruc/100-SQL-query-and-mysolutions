-- Bir kategoriye 15 ten fazla �r�n eklenemesin.
CREATE TRIGGER trg_UrunEkleme
ON Products
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @kategoriID int
	DECLARE @UrunAdi nvarchar(max)
	DECLARE @kategoriAdet int
	DECLARE @discontinued AS BIT

	
	SELECT @kategoriID=CategoryID,
		   @UrunAdi=ProductName 
	From inserted

	SELECT @kategoriAdet=COUNT(*) from Products	
	WHERE CategoryID = @kategoriID
    GROUP BY CategoryID

	IF @kategoriAdet>=15
	BEGIN 
	PRINT '15 adet �r�nden fazla �r�n girilemez'
	END
	ELSE
	BEGIN
		INSERT INTO Products(ProductName,CategoryID,Discontinued)
		VALUES(@UrunAdi,@kategoriID,@discontinued)
	END
END

INSERT INTO Products(ProductName,CategoryID,Discontinued)
VALUES('enes','1','1')



-- �al��anlar�m ayn� g�n i�erisinde bir m��teriye en fazla 2 sipari� g�nderebilsin.
-- 10 sipari�ten sonra m��teriye ald��� �r�nlerde %10 indirim uygulas�n.
GO

CREATE TRIGGER trg_IndirimUygula
ON Orders
AFTER INSERT
AS
BEGIN
	DECLARE @musteriIDSayisi int
	DECLARE @musteriID int
	DECLARE @siparisID int

	SELECT @musteriID=CustomerID,
		   @siparisID=OrderID,
		   @productID=ProductID
	 from inserted

	SELECT @musteriIDSayisi=COUNT(*) from Orders	
	WHERE CustomerID = @musteriID
    GROUP BY CustomerID

	IF @musteriIDSayisi>10
	BEGIN

		INSERT INTO Orders(OrderID,CustomerID,OrderDate)
		VALUES(@siparisID,@musteriID,GETDATE())


		INSERT INTO [Order Details](OrderID,Discount)
		VALUES(@siparisID,'0,10')

	END
	ELSE
	BEGIN
		INSERT INTO Orders(OrderID,CustomerID,OrderDate)
		VALUES(@siparisID,@musteriID,GETDATE())
	END
END

GO
-- Sipari� verilirken, sipari�te yer alan �r�nlerden herhangi biri kritik seviyenin alt�na d���yorsa sipari�i kaydetmeyip uyar� versin.

CREATE TRIGGER trg_KritikSeviyeUyar�
ON Orders
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @KritikSeviye int
	DECLARE @Urun NVARCHAR(50)

	SELECT  @KritikSeviye=(SELECT ReorderLevel FROM Products)

	

END



-- Verilen sipari�teki bir �r�n�n adet bilgisi yanl�� girilmi� ve d�zeltilmek istendi�inde o �r�n�n stok bilgisini de d�zeltsin.
GO

CREATE TRIGGER trg_StokDuzelt
ON [Order Details]
AFTER INSERT
AS
BEGIN
	DECLARE @UrunAdet int
	DECLARE @UrunStok int
	DECLARE @UrunAdi nvarchar(50)
	DECLARE @SiparisID int

	SELECT @SiparisID=OrderID FROM inserted
	SELECT 

END