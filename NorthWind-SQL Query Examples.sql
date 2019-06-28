-- Hangi tedarikçiden hangi ürünü kaç adet  temin etmiþim? Tedarikci | UrunAdedi
SELECT s.CompanyName AS Tedarikci,p.ProductName As Urun,SUM(p.UnitsInStock+p.UnitsOnOrder+od.Quantity) AS  Adet
FROM Products p 
	JOIN Suppliers s 
		ON s.SupplierID=p.SupplierID 
	JOIN [Order Details] od 
		ON p.ProductID=od.ProductID
GROUP BY s.CompanyName,p.ProductName


-- Nancy adýndaki personelim hangi firmaya toplam kaç adet ürün satmýþtýr? FirmaAdi | UrunAdet
SELECT c.CompanyName AS FirmaAdi, SUM(od.Quantity) As UrunAdet
FROM Employees e 
	JOIN Orders o 
		ON o.EmployeeID=e.EmployeeID 
	JOIN Customers c 
		ON c.CustomerID=o.CustomerID
		JOIN [Order Details] od 
			ON od.OrderID=o.OrderID
WHERE e.FirstName='nancy'
GROUP BY c.CompanyName


-- Batý bölgesinden sorumlu çalýþanlara ait müþteri sayýsý bilgisini getirin. Calisan | MusteriSayisi
SELECT e.FirstName AS Calisan, COUNT(o.CustomerID)
FROM Employees e 
	JOIN EmployeeTerritories et 
		ON e.EmployeeID=et.EmployeeID
	JOIN Territories t 
		ON et.TerritoryID=t.TerritoryID 
	JOIN Region r 
		ON r.RegionID=t.RegionID
		JOIN Orders o 
			ON o.EmployeeID=e.EmployeeID
WHERE r.RegionDescription='Western'
GROUP BY e.FirstName


-- Kategori adý Confections olan ürünleri hangi ülkelere fiyat olarak toplam ne kadar gönderdik ? Ulke | ToplamFiyat
SELECT o.ShipCountry AS Ulke, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
FROM Categories c 
	JOIN Products p 
		ON p.CategoryID=c.CategoryID 
	JOIN [Order Details] od 
		ON od.ProductID=p.ProductID 
	JOIN Orders o 
		ON o.OrderID= od.OrderID
WHERE c.CategoryName='Confections'
GROUP BY o.ShipCountry


-- Her bir ürün için ortalama talep sayýsý(ortalama sipariþ adeti) bilgisini ürün adýyla beraber listeleyin. UrunAdi | OrtalamaTalepSayýsý
SELECT p.ProductName AS UrunAdi,AVG(od.Quantity)
FROM Products p 
	JOIN [Order Details] od 
		ON od.ProductID=p.ProductID	
	JOIN Orders o 
		ON o.OrderID=od.OrderID
GROUP BY p.ProductName


-- 250'den fazla sipariþ taþýmýþ olan kargo firmalarýnýn adlarýný, telefon numaralarýný ve taþýdýklarý sipariþ sayýlarýný getiren sorguyu yazýn. FirmaAdi | Telefon | SiparisSayisi
SELECT s.CompanyName AS FirmaAdi,s.Phone AS Telefon,COUNT(*) AS SiparisSayisi
FROM Shippers s 
	JOIN Orders o 
		ON s.ShipperID=o.ShipVia
GROUP BY s.CompanyName,s.Phone
HAVING COUNT(*)>250


-- Müþterilerimin toplam sipariþ adetlerini Müþteri adý ile birlikte raporlayýn	CustomerName | TotalOrdersCount
SELECT c.CompanyName AS MusteriAdi,COUNT(o.OrderID) AS ToplamSiparisAdedi
FROM Customers c 
	JOIN Orders o 
		ON c.CustomerID=o.CustomerID
GROUP BY c.CompanyName


-- Kargo þirketlerine göre taþýnan sipariþ sayýlarý nedir? ShipperName | TotalOrdersCount
SELECT s.CompanyName AS KargoSirketi,COUNT(*)
FROM Orders o 
	JOIN Shippers s 
		ON s.ShipperID=o.ShipVia
GROUP BY s.CompanyName


-- Ürün Id ve isimlerini, bugünkü fiyatý ile birlikte bugüne kadar yer aldýðý sipariþlerdeki en ucuz fiyat ve bu fiyat ile arasýndaki farký da hesaplayarak listeleyin. ProductID | ProductName | UnitPrice | LowestPrice | Difference
SELECT p.ProductID  AS UrunID,p.ProductName AS UrunAdi,p.UnitPrice AS GuncelFiyat,MIN(od.UnitPrice) AS EnUcuz,(p.UnitPrice-MIN(od.UnitPrice)) AS Fark
FROM Products p 
	JOIN [Order Details] od 
		ON od.ProductID=p.ProductID 
	JOIN Orders o 
		ON o.OrderID=od.OrderID
GROUP BY p.ProductName,p.ProductID,p.UnitPrice


-- Sevilla þehri hariç Ýspanyaya gönderilen kargolarýn toplam adedi, toplam tutarý ve ortalama tutarýný þehirlere göre raporlayýn. City | TotalCount | TotalPrice | Average
SELECT o.ShipCity AS GonderilenSehir,COUNT(*) AS ToplamKargoAdedi,SUM(od.UnitPrice) AS ToplamTutar,AVG(od.UnitPrice) AS OrtalamaTutar
FROM Orders o 
	JOIN [Order Details] od 
		ON od.OrderID=o.OrderID
WHERE o.ShipCity<>'Sevilla' AND o.ShipCountry='spain'
GROUP BY o.ShipCity


-- Her yýl hangi ülkeye kaç adet sipariþ göndermiþim? Year | Country | TotalOrdersCount
SELECT YEAR(o.OrderDate) AS Yil,o.ShipCountry AS Ulke,COUNT(*) AS Adet
FROM Orders o
GROUP BY o.ShipCountry,YEAR(o.OrderDate)


-- En deðerli müþterim kim? (Bana en çok para kazandýran)
SELECT  TOP 1 c.CompanyName AS MusteriAdi,SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS [PARA PARA PARA]
FROM Customers c 
	JOIN Orders o 
		ON o.CustomerID=c.CustomerID 
	JOIN [Order Details] od 
		ON od.OrderID=o.OrderID
GROUP BY c.CompanyName
ORDER BY [PARA PARA PARA] DESC


-- Þehir bazýnda sipariþ adetlerim nelerdir? City | Count
SELECT o.ShipCity AS Sehir,SUM(od.Quantity) AS SiparisAdedi
FROM Orders o JOIN [Order Details] od 
	ON od.OrderID=o.OrderID
GROUP BY o.ShipCity
