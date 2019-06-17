-- CategoryID'si 2 olan kategorileri getirin
SELECT CategoryName
FROM Categories
WHERE CategoryID=2

-- Londrada ikamet eden �al��anlar�n ad ve soyadlar� nedir
SELECT FirstName +' '+LastName AS AdSoyad
FROM Employees
WHERE City='London'

-- Birim fiyat� 50 ile 80 aras� olan �r�nler nelerdir
SELECT ProductName
FROM Products
WHERE UnitPrice BETWEEN 50 AND 80

-- �lkesi A harfi ile bitmeyen m��terileri listeleyin
SELECT CompanyName,ContactName,Country
FROM Customers
WHERE Country NOT LIKE '%a'

-- 04.07.1996 ile 31.12.1996 tarihleri aras�nda verilen sipari�ler hangileridir
SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-07-04' AND '1996-12-31'
-- �r�n adlar�n� ve fiyatlar�n�, her birine %18 olarak uygulanmak �zere KDV bilgisiyle beraber listeleyin. KDV bilgisi ayr� bir s�tun olarak gelmeli.
SELECT ProductName,UnitPrice,CAST(UnitPrice*0.18 as DECIMAL(5,2)) AS KdvTutar�
FROM Products

-- Dairy Products kategorisine ait �r�nleri listeleyin.
SELECT CategoryName AS KategoriAdi
FROM Categories
WHERE CategoryName='Dairy Products' 
-- ���nc� harfi N olan �al��anlar�n ad ve soyadlar�n� listeleyin.
SELECT FirstName+' '+LastName AS AdSoyad
FROM Employees
WHERE FirstName LIKE '__N%'
-- �al��anlar�n a��k adreslerini ve telefonlar�n� raporlay�n.
SELECT FirstName+' '+LastName AS AdSoyad, Address+'/'+ City +'/'+Country AS AcikAdress,HomePhone AS Telefon
FROM Employees

-- Her bir kategorinin a��klamas�n�n ne oldu�unu raporlay�n.
SELECT CategoryName AS KategoriAdi,Description AS Aciklama
FROM Categories

-- Sipari�lerimin sipari� tarihlerini ve nereye g�nderileceklerini raporlay�n.
SELECT OrderDate AS SiparisTarihi,ShipAddress+'/'+ShipCity+'/'+ShipCountry AS GonderilecekAdres
FROM Orders

-- �r�nlerin ad�n�, kategori IDsini, birim fiyat�n� ve stok miktar�n� raporlay�n.
SELECT ProductName AS UrunAdi, CategoryID AS KategoriNo,UnitPrice AS BirimFiyati,UnitsInStock AS StokMiktari
FROM Products

-- Her bir tedarik�inin �irket ad� ve a��k adreslerini raporlay�n.
SELECT CompanyName AS SirketAdi, Address+'/'+City+'/'+Country AS AcikAdres
FROM Suppliers

-- Her bir m��terinin �irket ad� ve a��k adreslerini aras�nda '/' olacak �ekilde tek bir kolonda ve yetkili ki�iyle birlikte raporlay�n.
SELECT CompanyName+'/'+Address+'*'+City+'*'+Country AS SirketVeAdres,ContactName AS Yetkili
FROM Customers
-- �al��anlar�n ad�n� ve soyad�n� ba��nda unvanlar� ile birlikte tek bir kolonda listeleyin ve kolonun ad�n�n 'Ki�i Bilgisi' olmas�n� sa�lay�n.
SELECT Title+'/'+ FirstName+' '+LastName AS KisiBilgisi
FROM Employees

-- Birebir firma sahibi ile temas kurulan tedarik�ileri listeleyin
SELECT * FROM Suppliers
WHERE ContactTitle='owner'

-- Hangi �al��anlar�m Almanca biliyor
SELECT FirstName+' '+LastName AS AdSoyad
FROM Employees
WHERE Notes LIKE '%german%'

-- Stokta 40 tan fazla olan �r�nlerimin adlar� ve kategori Idleri
SELECT ProductName AS UrunAdi,CategoryID AS KategoriNo
FROM Products
WHERE UnitsInStock>40

-- �smi 'chai' olanlar�n ya da kategorisi 3 olan ve 29 dan fazla sto�u olan �r�nleri listeleyin
SELECT ProductName 
FROM Products
WHERE ProductName='Chai' OR (CategoryID=3 AND UnitsInStock>29)

-- Sto�u 42 ile 100 aras�nda olan �r�nleri listeleyin
SELECT * FROM Products
WHERE UnitsInStock BETWEEN 42 AND 100
ORDER BY UnitsInStock

-- Do�um tarihleri 1961-01-01 ve 2010-10-10 tarihleri aras�nda ve kad�n �al��anlar�m� listeleyin
SELECT * FROM Employees
WHERE BirthDate BETWEEN '1961-01-01' AND '2010-10-10' AND TitleOfCourtesy IN('MS.','MRS.')

-- Ya�ad��� �ehir London ve Seattle olmayan �al��anlar�m�z kimlerdir?
SELECT FirstName+' '+LastName AS AdSoyad,City AS YasadigiSehir
FROM Employees
WHERE City NOT IN('London','Seattle')

-- Ad�nda ve soyad�nda 'e' harfi ge�meyen �al��anlar�m�z kimlerdir?
SELECT * FROM Employees
WHERE FirstName  NOT LIKE '%e%' AND LastName NOT LIKE '%e%'

-- Stok miktar� kritik seviyeye veya alt�na d��mesine ra�men hala sipari�ini vermedi�im �r�nler hangileridir?
SELECT * FROM Products
WHERE UnitsInStock<=ReorderLevel AND UnitsOnOrder=0

-- �i�ede satt���m �r�nler nelerdir?
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
SELECT FirstName+' '+LastName AS AdSoyad,HireDate AS �seGirisTarihi
FROM Employees
WHERE HireDate>'1993-01-01'

-- Fiyat� k�s�ratl� �r�nleri bulun.
SELECT * FROM Products WHERE UnitPrice NOT LIKE '%,_%'

-- Elimde bulunan aktif �r�nlerin hepsini satt���mda, her birinden ne kadar kazanaca��m� raporlay�n. �r�n ad� ve kazanc� �eklinde iki kolon ile g�sterin.
SELECT SUM(UnitPrice*UnitsInStock) as ToplamKazanc
  FROM Products
-- Sto�u olmas�na ra�men art�k sat���n� yapmad���m �r�nler hangisidir?
SELECT ProductName
FROM Products
WHERE UnitsInStock > 0 AND Discontinued=1

-- Bolge bilgisi olmayan m��terilerin listesini raporlayiniz...
SELECT CompanyName+'/'+ContactName AS BolgeBilgisiOlmayanMusteriler
FROM Customers
WHERE Region IS NULL

-- B�lge bilgisi olan personellerimi gosteriniz...
SELECT * FROM Employees
WHERE Region IS NOT NULL

-- CategoryID'si 5 olan, urun bedeli 20'den buyuk 300'den kucuk olan, stok durumu null olmayan urunlerimin adlarini ve id'lerini gosteriniz...
SELECT ProductName AS UrunAdi,ProductID AS UrunID
FROM Products
WHERE CategoryID=5 AND (UnitPrice between 20 AND 300) AND UnitsInStock IS NOT NULL

-- 'Dumon' ya da 'Alfki' idlerine sahip olan musterilerden alinmis, 1 nolu personelin onayladigi, 3 nolu kargo firmasi tarafindan gonderilmis ve ShipRegion'u null olan siparisleri gosteriniz...
SELECT * FROM Orders
WHERE CustomerID IN('Dumon','Alfki') AND EmployeeID=1 AND ShipVia=3 AND ShipRegion IS NULL

-- Teslimat� Amerika'ya ge� kalan sipari�ler hangileridir?
SELECT * FROM Orders
WHERE ShippedDate>RequiredDate AND ShipCountry = 'USA'

-- Patron d���nda hangi �al��anlar Frans�zca biliyor?
SELECT * FROM Employees
WHERE TitleOfCourtesy<>'Dr.' AND Notes LIKE '%FRENCH%'

-- Hen�z teslimat� ger�ekle�memi� sipari�ler hangileridir?
SELECT * FROM Orders
WHERE ShippedDate IS NULL

-- 1 dolar�n alt�nda kargo �creti olan sipari�ler hangileridir?
SELECT * FROM Orders
WHERE Freight<1

-- Son g�n�nde teslim edilen sipari�ler hangileridir?
SELECT * FROM Orders
WHERE ShippedDate=RequiredDate

-- 01.11.1997 - 06.06.1998 tarihleri arasindaki siparisleri gosteriniz...
SELECT * FROM Orders
WHERE OrderDate BETWEEN '1997-11-01' AND '1998-06-06'
ORDER BY OrderDate

-- Sto�umda hi� bulunmay�p tedarik�ilerime sipari� verdi�im �r�nler hangileridir?
SELECT * FROM Products
WHERE UnitsInStock=0 AND Discontinued>0

-- Y�ksek lisans yapan �al��anlar�m hangileridir?
SELECT * FROM Employees
WHERE Notes LIKE '%ma%' or Notes LIKE 'mba' or Notes LIKE 'msc'
------------------------------------------------------------------------------------------------

-- T�m �al��anlar�m�n ad ve soyad�n� tek kolonda getirin ancak soyad�n tamam� b�y�k harf ile olsun
SELECT FirstName+' '+UPPER(LastName) AS AdSoyad
FROM Employees

-- M��terilerimin �irket isimlerinin ilk 3 harfini getirin.
SELECT LEFT(CompanyName,3) AS SirketIsmi
FROM Customers

-- Sistemde kay�tl� her �r�n i�in bir barkod numaras� olu�turulacakt�r. Barkod numaras� ID'sinin 3 kere tekrarlan�p ard�na da isminin ilk 3 harfinin eklendi�i �ekildedir. �rne�in Chai �r�n� i�in 111Cha �eklindedir. �r�nleri ve her biri i�in olu�an barkod numaras�n� listeleyin.
SELECT ProductName AS UrunAdi, REPLICATE(ProductID,3)+''+LEFT(ProductName,3) AS BarkodNumarasi
FROM Products

-- T�m �r�nlerin fiyatlar�n� virg�lden sonra 2 basamak gelecek �ekilde getirin.
SELECT ROUND(UnitPrice,2) 
FROM Products

-- Sipari�lerin g�nderildi�i �lkelerin ilk iki harfini k���k, gerisini b�y�k harf olacak �ekilde listeleyin.
SELECT  DISTINCT LOWER(LEFT(ShipCountry,2))+''+UPPER(SUBSTRING(ShipCountry,3,LEN(ShipCountry)-2)) AS Ulkeler
FROM Orders

-- T�m sipari� kalemlerinin tutar�n� hesaplay�n, hesaplad���n�z de�erler tamsay� olarak g�r�ns�n
SELECT ROUND(UnitPrice*Quantity*(1-Discount),0) AS Tutar
FROM [Order Details]

-- Her y�l ve her ay i�in ay�n 15'inden �nce sevk edilmi� sipari�leri listeleyin.
SELECT * FROM Orders
WHERE DAY(CASt(ShippedDate as datetime))<15

-- Birim fiyat� 20 ile 75 aras�nda olan ve gelecek sipari�i olan �r�nlerimin, yeni gelen �r�nler geldi�i zaman olu�acak stok miktar�n� ve g�ncel stok miktar�n� a�a��daki gibi bir kolonda yazd�r�n. Kolon ad� Stok Bilgisi olsun ve �r�n ad� ile birlikte listelensin. 'Mevcut Stok : 20, Gelecek Olan Sipari� : 30, Toplam Stok : 50'
SELECT ProductName AS UrunAdi,UnitsInStock As StokBilgisi,UnitsOnOrder AS GelecekStok,UnitsOnOrder+UnitsInStock AS Toplam
FROM Products 
WHERE (UnitPrice BETWEEn 20 AND 75) AND UnitsOnOrder<>0

-- �r�nlerime Birim Fiyat� 20 den az ise ayn� fiyat, 20 ve 50 aras�ndaysa %10 indirim, 50 ve 100 aras�ndaysa %20 indirim, 100 den fazlaysa %25 indirim yap�n. Birim fiyata g�re s�ralay�n
SELECT ProductName,UnitPrice, 'Durum' =
CASE 
    WHEN UnitPrice<20 THEN UnitPrice
    WHEN UnitPrice BETWEEN 20 AND 50 THEN (UnitPrice-(UnitPrice*10)/100)
    WHEN UnitPrice BETWEEN 50 AND 100 THEN (UnitPrice-(UnitPrice*25)/100)
END
FROM Products
Order BY UnitPrice

-- �al��anlar�m�n bu y�lki do�um g�nleri hangi g�ne denk gelmektedir?*************

SELECT FirstName+' '+LastName AS [�sim Soyisim],
DATENAME(WEEKDAY,DATEADD(YEAR,DATEDIFF(YEAR,BirthDate,GETDATE()),BirthDate)) AS DogumGunu
FROM Employees
	
-------------------------------------------------------------------------------------------------

-- Employees tablosuna kendi bilgilerinizle bir kay�t ekleyin.
INSERT INTO Employees(LastName,FirstName,Title,TitleOfCourtesy,Address,City,Country)
VALUES('Oru�','Enes','Student','Mr.','F�nd�kl� Mah.','�stanbul','Turkey')

-- Ekledi�iniz kay�ttaki �nvan bilgisini developer olarak g�ncelleyin
UPDATE Employees
SET Title='Developer'
WHERE FirstName='enes'

-- Kahve isminde bir kategori olu�turun ve a��klamas�na 'S�cak i�iniz' bilgisini ekleyin.
INSERT INTO Categories
VALUES('kahve','s�cak i�iniz',null)

-- Espresso isimli �r�n� kahve kategorisine ekleyin. Fiyat� 10, stok miktar� ise 50 olarak g�ncelleyin.
INSERT INTO Products(ProductName)
VALUES('espresso')

UPDATE Products
	SET UnitPrice = 10,
		UnitsInStock = 50
WHERE ProductName = 'espresso'

-- BLGDM kodu ile Bilge Adam isimli m��teriyi ekleyin.
INSERT INTO Customers(CustomerID,CompanyName)
VALUES('BLGDM','Bilge Adam')

-- Bilge Adam m��terisi 30 adet espresso sipari�i versin ve bu sipari�ler Speedy Express firmas� ile g�nderilsin. Kargo �creti 80 dolard�r ancak Bilge Adam anla�mal� oldu�undan %15 indirimi vard�r. Bu sipari�le developer �nvan�na sahip �al��an�m ilgileniyor. Sipari� verildikten sonra 5 g�n i�erisinde kargolanmal�.
INSERT INTO Orders(CustomerID,EmployeeID,OrderDate,RequiredDate,ShipVia,Freight)
VALUES ('BLGDM',12,GETDATE(),DATEADD(DAY,5,GETDATE()),1,80-(80*0.15))

--Kargo �creti 80 dolard�r ancak Bilge Adam anla�mal� oldu�undan %15 indirimi vard�r.
INSERT INTO Orders(CustomerID,EmployeeID,ShipVia,OrderDate,RequiredDate)
VALUES('BLGDM','11','1','2019-04-14','2019-04-19')

INSERT INTO [Order Details](OrderID,ProductID,Quantity,UnitPrice,Discount)
VALUES('11080','79','30','10',0)

-- Bir �nceki maddede belirtilen sipari� 2 g�n sonra teslim ediliyor. Gerekli g�ncellemeyi sisteme yans�t�n.
UPDATE Orders
SET ShippedDate=DATEADD(DAY,2,OrderDate)
WHERE OrderID='11080'

-- Yukar�daki t�m maddelerde yap�lan i�lemleri geri alacak sorguyu yaz�n.
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

-- Beverages kategorisine ait �r�nleri listeleyin(kategori,�r�n)
SELECT c.CategoryName AS KategoriAdi,p.ProductName AS UrunAdi
FROM Categories c JOIN Products p ON c.CategoryID=p.CategoryID 
WHERE c.CategoryName='beverages'

-- �ndirimli g�nderdi�im sipari�lerdeki �r�n adlar�n�, birim fiyat�n� ve indirim tutar�n� g�sterin
SELECT  DISTINCT p.ProductName AS UrunAdi,p.UnitPrice AS BirimFiyat, CONVERT(decimal(6,2),od.UnitPrice*Discount) AS [Indirim Tutar�]
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID JOIN Products p ON p.ProductID=od.ProductID
WHERE od.Discount>0

-- Federal Shipping ile ta��nm�� ve Nancy'nin alm�� oldu�u sipari�leri g�sterin
SELECT o.OrderID AS SiparisNo,e.FirstName AS �lgiliKisi,s.CompanyName As Tasiyici
FROM Shippers s JOIN Orders o ON s.ShipperID=o.ShipVia JOIN Employees e ON e.EmployeeID=o.EmployeeID
WHERE o.ShipVia='3' AND e.FirstName='Nancy'

-- Do�u konumundaki b�lgeleri listeleyin
SELECT TerritoryDescription FROM Territories t JOIN Region r ON r.RegionID=t.RegionID
WHERE r.RegionID=3

-- �ehri Londra olan tedarik�ilerimden temin etti�im ve sto�umda yeterli say�da bulunan, birim fiyat� 30 ile 60 aras�nda olan �r�nlerim nelerdir
SELECT * FROM Suppliers s JOIN Products p ON s.SupplierID=p.SupplierID 
WHERE s.City='london' AND p.ReorderLevel<p.UnitsInStock AND p.UnitPrice BETWEEN 30 AND 60

-- Chai �r�n�m� hangi m��terilerime satm���m?
SELECT  DISTINCT c.CompanyName AS SatinAlanSirket,p.ProductName AS Urun
FROM Products p JOIN [Order Details] od ON od.ProductID=p.ProductID 
JOIN Orders o ON o.OrderID=od.OrderID 
JOIN Customers c ON c.CustomerID=o.CustomerID
WHERE p.ProductName='chai'

-- A�ustos ay�nda teslim etti�im sipari�lerimdeki �r�nlerden, kategorisi i�ecek olanlar�n, isimlerini, teslim tarihlerini ve hangi �ehre teslim edildi�ini, kargo �cretine g�re ters s�ral� �ekilde listeleyin.
select p.ProductName AS UrunAdi,o.ShippedDate AS TeslimTarihi,o.ShipCity AS TeslimEdilenSehir 
from Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID 
JOIN Products p ON od.ProductID=p.ProductID 
JOIN Categories c ON c.CategoryID=p.CategoryID
WHERE c.Description LIKE '%drinks%' AND MONTH(o.ShippedDate)=8
ORDER BY Freight DESC

-- �irket �ahibi ile ileti�ime ge�ti�im Meksikal� m��terilerimin verdi�i sipari�lerden kargo �creti 30 dolar�n alt�nda olanlarla hangi �al��anlar�m ilgilenmi�tir?
SELECT DISTINCT c.ContactName AS MusteriAdi,c.ContactTitle AS Title,e.FirstName+' '+e.LastName AS AdSoyad 
FROM Employees e JOIN Orders o ON e.EmployeeID=o.EmployeeID 
JOIN Customers c ON c.CustomerID=o.CustomerID
WHERE c.ContactTitle='owner' AND c.City='M�xico D.F.' AND o.Freight<30

-- Seafood �r�nlerimden sipari� g�nderdi�im m��terilerimi listeleyin.
SELECT  DISTINCT p.ProductName AS UrunAdi,cus.CompanyName as MusteriAdi
FROM Categories c JOIN Products p ON c.CategoryID=p.CategoryID 
JOIN [Order Details] od ON p.ProductID=od.ProductID 
JOIN Orders o ON o.OrderID=od.OrderID 
JOIN Customers cus ON cus.CustomerID=o.CustomerID
WHERE c.CategoryName='seafood'

-- Hangi sipari�im hangi m��terime, ne zaman, hangi �al��an�m taraf�ndan ger�ekle�tirilmi�?
SELECT o.OrderID AS SiparisNo,c.CompanyName AS Musteri,o.OrderDate AS SiparisTarihi,e.FirstName+' '+e.LastName AS IlgilenenCalisan
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID 
JOIN Employees e ON e.EmployeeID=o.EmployeeID

-- B�lge bilgisi Northern olan �al��anlar�m�n onaylad��� sipari�lerimdeki kritik stok seviyesinde olan �r�nleri listeleyin. �r�n adi ve �al��an ad� listelensin ve tekrar eden kay�tlar olmas�n
SELECT DISTINCT p.ProductName AS UrunAdi,e.FirstName+' '+e.LastName AS �lgiliCalisan
FROm Products p JOIN [Order Details] od ON p.ProductID=od.ProductID 
JOIN Orders o ON o.OrderID=od.OrderID 
JOIN Employees e ON e.EmployeeID=o.EmployeeID 
JOIN EmployeeTerritories et ON e.EmployeeID=et.EmployeeID 
JOIN Territories t ON t.TerritoryID=et.TerritoryID 
JOIN Region r ON r.RegionID=t.RegionID
WHERE r.RegionDescription='Northern' AND p.ReorderLevel>p.UnitsInStock