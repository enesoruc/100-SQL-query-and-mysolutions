-- CategoryID'si 2 olan kategorileri getirin
SELECT CategoryName
FROM Categories
WHERE CategoryID=2

-- Londrada ikamet eden çalýþanlarýn ad ve soyadlarý nedir
SELECT FirstName +' '+LastName AS AdSoyad
FROM Employees
WHERE City='London'

-- Birim fiyatý 50 ile 80 arasý olan ürünler nelerdir
SELECT ProductName
FROM Products
WHERE UnitPrice BETWEEN 50 AND 80

-- Ülkesi A harfi ile bitmeyen müþterileri listeleyin
SELECT CompanyName,ContactName,Country
FROM Customers
WHERE Country NOT LIKE '%a'

-- 04.07.1996 ile 31.12.1996 tarihleri arasýnda verilen sipariþler hangileridir
SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-07-04' AND '1996-12-31'
-- Ürün adlarýný ve fiyatlarýný, her birine %18 olarak uygulanmak üzere KDV bilgisiyle beraber listeleyin. KDV bilgisi ayrý bir sütun olarak gelmeli.
SELECT ProductName,UnitPrice,CAST(UnitPrice*0.18 as DECIMAL(5,2)) AS KdvTutarý
FROM Products

-- Dairy Products kategorisine ait ürünleri listeleyin.
SELECT CategoryName AS KategoriAdi
FROM Categories
WHERE CategoryName='Dairy Products' 
-- Üçüncü harfi N olan çalýþanlarýn ad ve soyadlarýný listeleyin.
SELECT FirstName+' '+LastName AS AdSoyad
FROM Employees
WHERE FirstName LIKE '__N%'
-- Çalýþanlarýn açýk adreslerini ve telefonlarýný raporlayýn.
SELECT FirstName+' '+LastName AS AdSoyad, Address+'/'+ City +'/'+Country AS AcikAdress,HomePhone AS Telefon
FROM Employees

-- Her bir kategorinin açýklamasýnýn ne olduðunu raporlayýn.
SELECT CategoryName AS KategoriAdi,Description AS Aciklama
FROM Categories

-- Sipariþlerimin sipariþ tarihlerini ve nereye gönderileceklerini raporlayýn.
SELECT OrderDate AS SiparisTarihi,ShipAddress+'/'+ShipCity+'/'+ShipCountry AS GonderilecekAdres
FROM Orders

-- Ürünlerin adýný, kategori IDsini, birim fiyatýný ve stok miktarýný raporlayýn.
SELECT ProductName AS UrunAdi, CategoryID AS KategoriNo,UnitPrice AS BirimFiyati,UnitsInStock AS StokMiktari
FROM Products

-- Her bir tedarikçinin þirket adý ve açýk adreslerini raporlayýn.
SELECT CompanyName AS SirketAdi, Address+'/'+City+'/'+Country AS AcikAdres
FROM Suppliers

-- Her bir müþterinin þirket adý ve açýk adreslerini arasýnda '/' olacak þekilde tek bir kolonda ve yetkili kiþiyle birlikte raporlayýn.
SELECT CompanyName+'/'+Address+'*'+City+'*'+Country AS SirketVeAdres,ContactName AS Yetkili
FROM Customers
-- Çalýþanlarýn adýný ve soyadýný baþýnda unvanlarý ile birlikte tek bir kolonda listeleyin ve kolonun adýnýn 'Kiþi Bilgisi' olmasýný saðlayýn.
SELECT Title+'/'+ FirstName+' '+LastName AS KisiBilgisi
FROM Employees

-- Birebir firma sahibi ile temas kurulan tedarikçileri listeleyin
SELECT * FROM Suppliers
WHERE ContactTitle='owner'

-- Hangi çalýþanlarým Almanca biliyor
SELECT FirstName+' '+LastName AS AdSoyad
FROM Employees
WHERE Notes LIKE '%german%'

-- Stokta 40 tan fazla olan ürünlerimin adlarý ve kategori Idleri
SELECT ProductName AS UrunAdi,CategoryID AS KategoriNo
FROM Products
WHERE UnitsInStock>40

-- Ýsmi 'chai' olanlarýn ya da kategorisi 3 olan ve 29 dan fazla stoðu olan ürünleri listeleyin
SELECT ProductName 
FROM Products
WHERE ProductName='Chai' OR (CategoryID=3 AND UnitsInStock>29)

-- Stoðu 42 ile 100 arasýnda olan ürünleri listeleyin
SELECT * FROM Products
WHERE UnitsInStock BETWEEN 42 AND 100
ORDER BY UnitsInStock

-- Doðum tarihleri 1961-01-01 ve 2010-10-10 tarihleri arasýnda ve kadýn çalýþanlarýmý listeleyin
SELECT * FROM Employees
WHERE BirthDate BETWEEN '1961-01-01' AND '2010-10-10' AND TitleOfCourtesy IN('MS.','MRS.')

-- Yaþadýðý þehir London ve Seattle olmayan çalýþanlarýmýz kimlerdir?
SELECT FirstName+' '+LastName AS AdSoyad,City AS YasadigiSehir
FROM Employees
WHERE City NOT IN('London','Seattle')

-- Adýnda ve soyadýnda 'e' harfi geçmeyen çalýþanlarýmýz kimlerdir?
SELECT * FROM Employees
WHERE FirstName  NOT LIKE '%e%' AND LastName NOT LIKE '%e%'

-- Stok miktarý kritik seviyeye veya altýna düþmesine raðmen hala sipariþini vermediðim ürünler hangileridir?
SELECT * FROM Products
WHERE UnitsInStock<=ReorderLevel AND UnitsOnOrder=0

-- Þiþede sattýðým ürünler nelerdir?
SELECT * FROM Products
WHERE QuantityPerUnit LIKE '%bottles%'

-- Londra'da yasayan personellerimin adini soyadini gosteriniz...
SELECT FirstName+' '+LastName AS AsSoyad
FROM Employees
WHERE City='London'

-- CategoryID'si 5 olmayan urunleri listeleyiniz..
SELECT ProductName,CategoryID
FROM Products
WHERE CategoryID<> 5

-- 01.01.1993'ten sonra ise giren personelleri listeleyiniz...
SELECT FirstName+' '+LastName AS AdSoyad,HireDate AS ÝseGirisTarihi
FROM Employees
WHERE HireDate>'1993-01-01'

-- Fiyatý küsüratlý ürünleri bulun.
SELECT * FROM Products WHERE UnitPrice NOT LIKE '%,_%'

-- Elimde bulunan aktif ürünlerin hepsini sattýðýmda, her birinden ne kadar kazanacaðýmý raporlayýn. Ürün adý ve kazancý þeklinde iki kolon ile gösterin.
SELECT SUM(UnitPrice*UnitsInStock) as ToplamKazanc
  FROM Products
-- Stoðu olmasýna raðmen artýk satýþýný yapmadýðým ürünler hangisidir?
SELECT ProductName
FROM Products
WHERE UnitsInStock > 0 AND Discontinued=1

-- Bolge bilgisi olmayan müþterilerin listesini raporlayiniz...
SELECT CompanyName+'/'+ContactName AS BolgeBilgisiOlmayanMusteriler
FROM Customers
WHERE Region IS NULL

-- Bölge bilgisi olan personellerimi gosteriniz...
SELECT * FROM Employees
WHERE Region IS NOT NULL

-- CategoryID'si 5 olan, urun bedeli 20'den buyuk 300'den kucuk olan, stok durumu null olmayan urunlerimin adlarini ve id'lerini gosteriniz...
SELECT ProductName AS UrunAdi,ProductID AS UrunID
FROM Products
WHERE CategoryID=5 AND (UnitPrice between 20 AND 300) AND UnitsInStock IS NOT NULL

-- 'Dumon' ya da 'Alfki' idlerine sahip olan musterilerden alinmis, 1 nolu personelin onayladigi, 3 nolu kargo firmasi tarafindan gonderilmis ve ShipRegion'u null olan siparisleri gosteriniz...
SELECT * FROM Orders
WHERE CustomerID IN('Dumon','Alfki') AND EmployeeID=1 AND ShipVia=3 AND ShipRegion IS NULL

-- Teslimatý Amerika'ya geç kalan sipariþler hangileridir?
SELECT * FROM Orders
WHERE ShippedDate>RequiredDate AND ShipCountry = 'USA'

-- Patron dýþýnda hangi çalýþanlar Fransýzca biliyor?
SELECT * FROM Employees
WHERE TitleOfCourtesy<>'Dr.' AND Notes LIKE '%FRENCH%'

-- Henüz teslimatý gerçekleþmemiþ sipariþler hangileridir?
SELECT * FROM Orders
WHERE ShippedDate IS NULL

-- 1 dolarýn altýnda kargo ücreti olan sipariþler hangileridir?
SELECT * FROM Orders
WHERE Freight<1

-- Son gününde teslim edilen sipariþler hangileridir?
SELECT * FROM Orders
WHERE ShippedDate=RequiredDate

-- 01.11.1997 - 06.06.1998 tarihleri arasindaki siparisleri gosteriniz...
SELECT * FROM Orders
WHERE OrderDate BETWEEN '1997-11-01' AND '1998-06-06'
ORDER BY OrderDate

-- Stoðumda hiç bulunmayýp tedarikçilerime sipariþ verdiðim ürünler hangileridir?
SELECT * FROM Products
WHERE UnitsInStock=0 AND Discontinued>0

-- Yüksek lisans yapan çalýþanlarým hangileridir?
SELECT * FROM Employees
WHERE Notes LIKE '%ma%' or Notes LIKE 'mba' or Notes LIKE 'msc'
------------------------------------------------------------------------------------------------

-- Tüm çalýþanlarýmýn ad ve soyadýný tek kolonda getirin ancak soyadýn tamamý büyük harf ile olsun
SELECT FirstName+' '+UPPER(LastName) AS AdSoyad
FROM Employees

-- Müþterilerimin þirket isimlerinin ilk 3 harfini getirin.
SELECT LEFT(CompanyName,3) AS SirketIsmi
FROM Customers

-- Sistemde kayýtlý her ürün için bir barkod numarasý oluþturulacaktýr. Barkod numarasý ID'sinin 3 kere tekrarlanýp ardýna da isminin ilk 3 harfinin eklendiði þekildedir. Örneðin Chai ürünü için 111Cha þeklindedir. Ürünleri ve her biri için oluþan barkod numarasýný listeleyin.
SELECT ProductName AS UrunAdi, REPLICATE(ProductID,3)+''+LEFT(ProductName,3) AS BarkodNumarasi
FROM Products

-- Tüm ürünlerin fiyatlarýný virgülden sonra 2 basamak gelecek þekilde getirin.
SELECT ROUND(UnitPrice,2) 
FROM Products

-- Sipariþlerin gönderildiði ülkelerin ilk iki harfini küçük, gerisini büyük harf olacak þekilde listeleyin.
SELECT  DISTINCT LOWER(LEFT(ShipCountry,2))+''+UPPER(SUBSTRING(ShipCountry,3,LEN(ShipCountry)-2)) AS Ulkeler
FROM Orders

-- Tüm sipariþ kalemlerinin tutarýný hesaplayýn, hesapladýðýnýz deðerler tamsayý olarak görünsün
SELECT ROUND(UnitPrice*Quantity*(1-Discount),0) AS Tutar
FROM [Order Details]

-- Her yýl ve her ay için ayýn 15'inden önce sevk edilmiþ sipariþleri listeleyin.
SELECT * FROM Orders
WHERE DAY(CASt(ShippedDate as datetime))<15

-- Birim fiyatý 20 ile 75 arasýnda olan ve gelecek sipariþi olan ürünlerimin, yeni gelen ürünler geldiði zaman oluþacak stok miktarýný ve güncel stok miktarýný aþaðýdaki gibi bir kolonda yazdýrýn. Kolon adý Stok Bilgisi olsun ve ürün adý ile birlikte listelensin. 'Mevcut Stok : 20, Gelecek Olan Sipariþ : 30, Toplam Stok : 50'
SELECT ProductName AS UrunAdi,UnitsInStock As StokBilgisi,UnitsOnOrder AS GelecekStok,UnitsOnOrder+UnitsInStock AS Toplam
FROM Products 
WHERE (UnitPrice BETWEEn 20 AND 75) AND UnitsOnOrder<>0

-- Ürünlerime Birim Fiyatý 20 den az ise ayný fiyat, 20 ve 50 arasýndaysa %10 indirim, 50 ve 100 arasýndaysa %20 indirim, 100 den fazlaysa %25 indirim yapýn. Birim fiyata göre sýralayýn
SELECT ProductName,UnitPrice, 'Durum' =
CASE 
    WHEN UnitPrice<20 THEN UnitPrice
    WHEN UnitPrice BETWEEN 20 AND 50 THEN (UnitPrice-(UnitPrice*10)/100)
    WHEN UnitPrice BETWEEN 50 AND 100 THEN (UnitPrice-(UnitPrice*25)/100)
END
FROM Products
Order BY UnitPrice

-- Çalýþanlarýmýn bu yýlki doðum günleri hangi güne denk gelmektedir?*************

SELECT FirstName+' '+LastName AS [Ýsim Soyisim],
DATENAME(WEEKDAY,DATEADD(YEAR,DATEDIFF(YEAR,BirthDate,GETDATE()),BirthDate)) AS DogumGunu
FROM Employees
	
-------------------------------------------------------------------------------------------------

-- Employees tablosuna kendi bilgilerinizle bir kayýt ekleyin.
INSERT INTO Employees(LastName,FirstName,Title,TitleOfCourtesy,Address,City,Country)
VALUES('Oruç','Enes','Student','Mr.','Fýndýklý Mah.','Ýstanbul','Turkey')

-- Eklediðiniz kayýttaki ünvan bilgisini developer olarak güncelleyin
UPDATE Employees
SET Title='Developer'
WHERE FirstName='enes'

-- Kahve isminde bir kategori oluþturun ve açýklamasýna 'Sýcak içiniz' bilgisini ekleyin.
INSERT INTO Categories
VALUES('kahve','sýcak içiniz',null)

-- Espresso isimli ürünü kahve kategorisine ekleyin. Fiyatý 10, stok miktarý ise 50 olarak güncelleyin.
INSERT INTO Products(ProductName)
VALUES('espresso')

UPDATE Products
	SET UnitPrice = 10,
		UnitsInStock = 50
WHERE ProductName = 'espresso'

-- BLGDM kodu ile Bilge Adam isimli müþteriyi ekleyin.
INSERT INTO Customers(CustomerID,CompanyName)
VALUES('BLGDM','Bilge Adam')

-- Bilge Adam müþterisi 30 adet espresso sipariþi versin ve bu sipariþler Speedy Express firmasý ile gönderilsin. Kargo ücreti 80 dolardýr ancak Bilge Adam anlaþmalý olduðundan %15 indirimi vardýr. Bu sipariþle developer ünvanýna sahip çalýþaným ilgileniyor. Sipariþ verildikten sonra 5 gün içerisinde kargolanmalý.
INSERT INTO Orders(CustomerID,EmployeeID,OrderDate,RequiredDate,ShipVia,Freight)
VALUES ('BLGDM',12,GETDATE(),DATEADD(DAY,5,GETDATE()),1,80-(80*0.15))

--Kargo ücreti 80 dolardýr ancak Bilge Adam anlaþmalý olduðundan %15 indirimi vardýr.
INSERT INTO Orders(CustomerID,EmployeeID,ShipVia,OrderDate,RequiredDate)
VALUES('BLGDM','11','1','2019-04-14','2019-04-19')

INSERT INTO [Order Details](OrderID,ProductID,Quantity,UnitPrice,Discount)
VALUES('11080','79','30','10',0)

-- Bir önceki maddede belirtilen sipariþ 2 gün sonra teslim ediliyor. Gerekli güncellemeyi sisteme yansýtýn.
UPDATE Orders
SET ShippedDate=DATEADD(DAY,2,OrderDate)
WHERE OrderID='11080'

-- Yukarýdaki tüm maddelerde yapýlan iþlemleri geri alacak sorguyu yazýn.
DELETE FROM Employees WHERE EmployeeID = 12
GO
DELETE FROM Categories WHERE CategoryID = 9
GO
DELETE FROM Products WHERE ProductID = 78
GO
DELETE FROM Customers WHERE CustomerID = 'BLGDM'
GO
DELETE FROM Orders WHERE OrderID = 11078
GO
DELETE FROM [Order Details] WHERE OrderID = 11078
GO

-----------------------------------------------------------------------------------------------

-- Beverages kategorisine ait ürünleri listeleyin(kategori,ürün)
SELECT c.CategoryName AS KategoriAdi,p.ProductName AS UrunAdi
FROM Categories c JOIN Products p ON c.CategoryID=p.CategoryID 
WHERE c.CategoryName='beverages'

-- Ýndirimli gönderdiðim sipariþlerdeki ürün adlarýný, birim fiyatýný ve indirim tutarýný gösterin
SELECT  DISTINCT p.ProductName AS UrunAdi,p.UnitPrice AS BirimFiyat, CONVERT(decimal(6,2),od.UnitPrice*Discount) AS [Indirim Tutarý]
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID JOIN Products p ON p.ProductID=od.ProductID
WHERE od.Discount>0

-- Federal Shipping ile taþýnmýþ ve Nancy'nin almýþ olduðu sipariþleri gösterin
SELECT o.OrderID AS SiparisNo,e.FirstName AS ÝlgiliKisi,s.CompanyName As Tasiyici
FROM Shippers s JOIN Orders o ON s.ShipperID=o.ShipVia JOIN Employees e ON e.EmployeeID=o.EmployeeID
WHERE o.ShipVia='3' AND e.FirstName='Nancy'

-- Doðu konumundaki bölgeleri listeleyin
SELECT TerritoryDescription FROM Territories t JOIN Region r ON r.RegionID=t.RegionID
WHERE r.RegionID=3

-- Þehri Londra olan tedarikçilerimden temin ettiðim ve stoðumda yeterli sayýda bulunan, birim fiyatý 30 ile 60 arasýnda olan ürünlerim nelerdir
SELECT * FROM Suppliers s JOIN Products p ON s.SupplierID=p.SupplierID 
WHERE s.City='london' AND p.ReorderLevel<p.UnitsInStock AND p.UnitPrice BETWEEN 30 AND 60

-- Chai ürünümü hangi müþterilerime satmýþým?
SELECT  DISTINCT c.CompanyName AS SatinAlanSirket,p.ProductName AS Urun
FROM Products p JOIN [Order Details] od ON od.ProductID=p.ProductID 
JOIN Orders o ON o.OrderID=od.OrderID 
JOIN Customers c ON c.CustomerID=o.CustomerID
WHERE p.ProductName='chai'

-- Aðustos ayýnda teslim ettiðim sipariþlerimdeki ürünlerden, kategorisi içecek olanlarýn, isimlerini, teslim tarihlerini ve hangi þehre teslim edildiðini, kargo ücretine göre ters sýralý þekilde listeleyin.
select p.ProductName AS UrunAdi,o.ShippedDate AS TeslimTarihi,o.ShipCity AS TeslimEdilenSehir 
from Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID 
JOIN Products p ON od.ProductID=p.ProductID 
JOIN Categories c ON c.CategoryID=p.CategoryID
WHERE c.Description LIKE '%drinks%' AND MONTH(o.ShippedDate)=8
ORDER BY Freight DESC

-- Þirket þahibi ile iletiþime geçtiðim Meksikalý müþterilerimin verdiði sipariþlerden kargo ücreti 30 dolarýn altýnda olanlarla hangi çalýþanlarým ilgilenmiþtir?
SELECT DISTINCT c.ContactName AS MusteriAdi,c.ContactTitle AS Title,e.FirstName+' '+e.LastName AS AdSoyad 
FROM Employees e JOIN Orders o ON e.EmployeeID=o.EmployeeID 
JOIN Customers c ON c.CustomerID=o.CustomerID
WHERE c.ContactTitle='owner' AND c.City='México D.F.' AND o.Freight<30

-- Seafood ürünlerimden sipariþ gönderdiðim müþterilerimi listeleyin.
SELECT  DISTINCT p.ProductName AS UrunAdi,cus.CompanyName as MusteriAdi
FROM Categories c JOIN Products p ON c.CategoryID=p.CategoryID 
JOIN [Order Details] od ON p.ProductID=od.ProductID 
JOIN Orders o ON o.OrderID=od.OrderID 
JOIN Customers cus ON cus.CustomerID=o.CustomerID
WHERE c.CategoryName='seafood'

-- Hangi sipariþim hangi müþterime, ne zaman, hangi çalýþaným tarafýndan gerçekleþtirilmiþ?
SELECT o.OrderID AS SiparisNo,c.CompanyName AS Musteri,o.OrderDate AS SiparisTarihi,e.FirstName+' '+e.LastName AS IlgilenenCalisan
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID 
JOIN Employees e ON e.EmployeeID=o.EmployeeID

-- Bölge bilgisi Northern olan çalýþanlarýmýn onayladýðý sipariþlerimdeki kritik stok seviyesinde olan ürünleri listeleyin. Ürün adi ve çalýþan adý listelensin ve tekrar eden kayýtlar olmasýn
SELECT DISTINCT p.ProductName AS UrunAdi,e.FirstName+' '+e.LastName AS ÝlgiliCalisan
FROm Products p JOIN [Order Details] od ON p.ProductID=od.ProductID 
JOIN Orders o ON o.OrderID=od.OrderID 
JOIN Employees e ON e.EmployeeID=o.EmployeeID 
JOIN EmployeeTerritories et ON e.EmployeeID=et.EmployeeID 
JOIN Territories t ON t.TerritoryID=et.TerritoryID 
JOIN Region r ON r.RegionID=t.RegionID
WHERE r.RegionDescription='Northern' AND p.ReorderLevel>p.UnitsInStock