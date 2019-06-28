-- Hangi siparişim hangi müşterime, ne zaman, hangi çalışanım tarafından verilmiştir.
SELECT OrderID AS SiparisNo,
			(SELECT CompanyName 
			FROM Customers c
			WHERE c.CustomerID=o.CustomerID) AS Musteri,
			OrderDate AS SiparisTarih,
			(SELECT FirstName  
				FROM Employees
				WHERE EmployeeID=o.EmployeeID) AS Calisan
FROM Orders o

-- Son 10 siparişte satılan ürünleri, kategorileri ile birlikte getirin

SELECT (SELECT p.ProductName FROM Products p
							WHERE p.ProductID=od.ProductID) AS Urun,
(SELECT c.CategoryName FROM Categories c WHERE c.CategoryID=(SELECT CategoryID FROM Products p
							WHERE od.ProductID=p.ProductID)) AS KategoriAdi
FROM [Order Details] od
							WHERE od.OrderID IN (SELECT TOP 10 o.OrderID FROM Orders o ORDER BY OrderID DESC)

-- İlk 15 siparişimi hangi firmalardan almışım?
SELECT TOP 15 OrderID,(SELECT CompanyName FROM Customers WHERE o.CustomerID = CustomerID) AS Firmaİsmi
FROM Orders o
ORDER BY OrderID

-- Kuzey (Northern) bölgesinden çalışan(lar)ım kim?

SELECT FirstName+' '+LastName AS Calisan FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories
WHERE TerritoryID IN (SELECT TerritoryID FROM Territories
WHERE RegionID IN (SELECT RegionID FROM Region
WHERE RegionDescription='Northern')))

-- New York şehrinden sorumlu çalışan(lar)ım kim?

SELECT FirstName+' '+LastName AS Calisan FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories
WHERE TerritoryID IN (SELECT TerritoryID FROM Territories 
WHERE TerritoryDescription='New York'))

-- Amerikada yaşayan çalışanlarımın almış olduğu siparişlerin listesi

SELECT * FROM Orders
WHERE EmployeeID IN (SELECT EmployeeID FROM Employees
WHERE Country='USA')

-- İndirim Uygulanan Siparişlerde hangi ürüne ne kadar indirim uygulanmış (ürün adı ve SiparişID'si ile beraber getiriniz)

SELECT (SELECT ProductName FROM Products p
WHERE p.ProductID=od.ProductID) AS UrunAdi,(SELECT OrderID FROM Orders o
WHERE o.OrderID=od.OrderID) AS UrunID,UnitPrice*(1-Discount) AS indirimMiktari
FROM [Order Details] od
WHERE Discount<>0

-- Üreticilerin çalışabileceği tüm olası gemi şirketleri.
SELECT * FROM Shippers

-- Federal Shipping ile taşınmış ve Nancy'nin almış olduğu siparişleri gösteriniz (OrderID, FirstName, lAStName, OrderDate, CompanyName)

SELECT o.OrderID,(SELECT FirstName+' '+LastName FROM Employees WHERE o.EmployeeID = EmployeeID) AS FullName,o.OrderDate,(SELECT CompanyName FROM Customers WHERE o.CustomerID = CustomerID) AS CompanyName
FROM Orders o
WHERE o.ShipVia = (SELECT ShipperID FROM Shippers s WHERE s.CompanyName = 'Federal Shipping') AND o.EmployeeID = (SELECT EmployeeID FROM Employees e WHERE e.FirstName = 'Nancy')

-- EmployeeId si 1 olan çalışanımın satmış olduğu ürünleri getiren sorguyu yazınız.

SELECT ProductName FROM Products p
WHERE p.ProductID IN (SELECT ProductID FROM [Order Details]
WHERE OrderID IN (SELECT OrderID FROM Orders
WHERE EmployeeID=1))

-- Siparişler tablosunda 4 ten az kaydı olan firmalar

SELECT CompanyName
FROM Customers c
WHERE c.CustomerID IN(SELECT CustomerID FROM Orders GROUP BY CustomerID HAVING COUNT(CustomerID)<4)

-- Müşterilerin ilk gerçekleştirdiği sipariş tarihleri

SELECT OrderDate,(SELECT Top 1 CustomerID
FROM Customers
GROUP BY CustomerID)
FROM Orders o


-- Kargo ücreti, en pahalı üründen yüksek olan siparişler. Freight | OrderID | MostExpensiveProduct
SELECT Freight,OrderID
FROM Orders o
HAVING MAX(Freight)>(SELECT MAX(UnitPrice) FROM [Order Details] od 
WHERE o.OrderID=od.OrderID)


-- 50den fazla satış yapan elemanlar

SELECT e.FirstName+' '+e.LastName AS AdSoyad
FROM Employees e
WHERE e.EmployeeID IN(SELECT EmployeeID FROM Orders GROUP BY EmployeeID HAVING COUNT(*)>50)

-- Hangi ülkede hangi sipariş, en geç teslim edilmiştir?
SELECT OrderID,(SELECT ShipCountry FROM Orders o1
WHERE o1.OrderID=o.OrderID AND o1.RequiredDate<o1.ShippedDate) AS SiparisNo
 FROM Orders o

SELECT (SELECT  FROM Orders o1)
FROM Orders o
WHERE e.EmployeeID IN(SELECT EmployeeID FROM Orders GROUP BY EmployeeID HAVING COUNT(*)>50)
