select sum(B.total) from (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc) as A inner join (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc) as B on B.productName=A.productName ;
select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc limit 10;


select cast(sum(B.total) as real) from (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc) as A inner join (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc limit 10) as B on B.productName=A.productName ;
sum(B.total)


select sum(B.total) from (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc) as B / sum(A.total) from (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc) as A


select cast(sum(B.total) as float) /sum(A.total) from (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc) as A left join (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc limit 20) as B on B.productName=A.productName;

select count(A.productname) from (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc) as A left join (select distinct a.productname,sum(b.Quantity) as total from products a left join 'Order Details' b on a.productID=b.productID group by a.productname order by total desc limit 20) as B on B.productName=A.productName;


select distinct a.City,a.Country,count( distinct a.CustomerID),sum((c.UnitPrice*(1.0-c.Discount)*c.Quantity)) as ordertotals from customers as a left join Orders as b on b.CustomerId=a.CustomerId left join 'Order Details' as c on b.OrderID=c.OrderID group by a.City,a.Country order by a.City desc;


select sum(UnitPrice*Quantity) from (select distinct a.OrderID,b.ProductID, b.UnitPrice,b.Quantity from orders as a inner join 'Order Details' as b on a.OrderID=b.OrderID inner join customers as c on c.CustomerID=a.CustomerID where c.City="Berlin");

select distinct a.OrderID, b.ProductID, b.UnitPrice, b.Quantity, b.Discount from orders as a inner join 'Order Details' as b on a.OrderID=b.OrderID inner join customers as c on c.CustomerID=a.CustomerID where c.City="Cowes";
