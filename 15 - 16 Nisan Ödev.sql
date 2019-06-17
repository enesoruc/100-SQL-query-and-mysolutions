-- Hangi tedarik�iden hangi �r�n� ka� adet  temin etmi�im? Tedarikci | UrunAdedi
SELECT s.CompanyName AS Tedarikci,p.ProductName As Urun,SUM(p.UnitsInStock+p.UnitsOnOrder+od.Quantity) AS  Adet
FROM Products p 
	JOIN Suppliers s 
		ON s.SupplierID=p.SupplierID 
	JOIN [Order Details] od 
		ON p.ProductID=od.ProductID
GROUP BY s.CompanyName,p.ProductName


-- Nancy ad�ndaki personelim hangi firmaya toplam ka� adet �r�n satm��t�r? FirmaAdi | UrunAdet
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


-- Bat� b�lgesinden sorumlu �al��anlara ait m��teri say�s� bilgisini getirin. Calisan | MusteriSayisi
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


-- Kategori ad� Confections olan �r�nleri hangi �lkelere fiyat olarak toplam ne kadar g�nderdik ? Ulke | ToplamFiyat
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


-- Her bir �r�n i�in ortalama talep say�s�(ortalama sipari� adeti) bilgisini �r�n ad�yla beraber listeleyin. UrunAdi | OrtalamaTalepSay�s�
SELECT p.ProductName AS UrunAdi,AVG(od.Quantity)
FROM Products p 
	JOIN [Order Details] od 
		ON od.ProductID=p.ProductID	
	JOIN Orders o 
		ON o.OrderID=od.OrderID
GROUP BY p.ProductName


-- 250'den fazla sipari� ta��m�� olan kargo firmalar�n�n adlar�n�, telefon numaralar�n� ve ta��d�klar� sipari� say�lar�n� getiren sorguyu yaz�n. FirmaAdi | Telefon | SiparisSayisi
SELECT s.CompanyName AS FirmaAdi,s.Phone AS Telefon,COUNT(*) AS SiparisSayisi
FROM Shippers s 
	JOIN Orders o 
		ON s.ShipperID=o.ShipVia
GROUP BY s.CompanyName,s.Phone
HAVING COUNT(*)>250


-- M��terilerimin toplam sipari� adetlerini M��teri ad� ile birlikte raporlay�n	CustomerName | TotalOrdersCount
SELECT c.CompanyName AS MusteriAdi,COUNT(o.OrderID) AS ToplamSiparisAdedi
FROM Customers c 
	JOIN Orders o 
		ON c.CustomerID=o.CustomerID
GROUP BY c.CompanyName


-- Kargo �irketlerine g�re ta��nan sipari� say�lar� nedir? ShipperName | TotalOrdersCount
SELECT s.CompanyName AS KargoSirketi,COUNT(*)
FROM Orders o 
	JOIN Shippers s 
		ON s.ShipperID=o.ShipVia
GROUP BY s.CompanyName


-- �r�n Id ve isimlerini, bug�nk� fiyat� ile birlikte bug�ne kadar yer ald��� sipari�lerdeki en ucuz fiyat ve bu fiyat ile aras�ndaki fark� da hesaplayarak listeleyin. ProductID | ProductName | UnitPrice | LowestPrice | Difference
SELECT p.ProductID  AS UrunID,p.ProductName AS UrunAdi,p.UnitPrice AS GuncelFiyat,MIN(od.UnitPrice) AS EnUcuz,(p.UnitPrice-MIN(od.UnitPrice)) AS Fark
FROM Products p 
	JOIN [Order Details] od 
		ON od.ProductID=p.ProductID 
	JOIN Orders o 
		ON o.OrderID=od.OrderID
GROUP BY p.ProductName,p.ProductID,p.UnitPrice


-- Sevilla �ehri hari� �spanyaya g�nderilen kargolar�n toplam adedi, toplam tutar� ve ortalama tutar�n� �ehirlere g�re raporlay�n. City | TotalCount | TotalPrice | Average
SELECT o.ShipCity AS GonderilenSehir,COUNT(*) AS ToplamKargoAdedi,SUM(od.UnitPrice) AS ToplamTutar,AVG(od.UnitPrice) AS OrtalamaTutar
FROM Orders o 
	JOIN [Order Details] od 
		ON od.OrderID=o.OrderID
WHERE o.ShipCity<>'Sevilla' AND o.ShipCountry='spain'
GROUP BY o.ShipCity


-- Her y�l hangi �lkeye ka� adet sipari� g�ndermi�im? Year | Country | TotalOrdersCount
SELECT YEAR(o.OrderDate) AS Yil,o.ShipCountry AS Ulke,COUNT(*) AS Adet
FROM Orders o
GROUP BY o.ShipCountry,YEAR(o.OrderDate)


-- En de�erli m��terim kim? (Bana en �ok para kazand�ran)
SELECT  TOP 1 c.CompanyName AS MusteriAdi,SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS [PARA PARA PARA]
FROM Customers c 
	JOIN Orders o 
		ON o.CustomerID=c.CustomerID 
	JOIN [Order Details] od 
		ON od.OrderID=o.OrderID
GROUP BY c.CompanyName
ORDER BY [PARA PARA PARA] DESC


-- �ehir baz�nda sipari� adetlerim nelerdir? City | Count
SELECT o.ShipCity AS Sehir,SUM(od.Quantity) AS SiparisAdedi
FROM Orders o JOIN [Order Details] od 
	ON od.OrderID=o.OrderID
GROUP BY o.ShipCity