var express = require('express');
var request = require('request');
var fs = require('fs');
var bodyParser = require('body-parser');
var sqlite3 = require("sqlite3").verbose();
var cors = require('cors');

// var db = new sqlite3.Database("mapping.db");
var db = new sqlite3.Database("Northwind.sl3")

var app = express();
app.use(cors());

var array = [];
app.use(express.static(__dirname + '/public'));

app.get('/northwind',function(req,res)
{
  res.sendFile(__dirname + '/public/index.html');
});


//Partition total sales revenue, quantity and product by city
app.get('/northwind/:city',function(req,res)
{
  if(req.params.city!=='favicon.ico')
    {
          db.all("select distinct d.ProductName, sum((b.UnitPrice*(1.0-b.Discount)*b.Quantity)) as totalrev, sum(b.Quantity) as sumquant from orders as a inner join 'Order Details' as b on a.OrderID=b.OrderID inner join products as d on d.ProductID=b.ProductID inner join customers as c on c.CustomerID=a.CustomerID where c.City=(?) group by d.ProductName order by totalrev desc",
          req.params.city,
          function(err, row)
            {
            if(err) {throw err;}
            res.json(row);
            });
    };
});


// Extract all the cities from the Northwind dataset
// app.get('/cities',function(req,res)
// {
//   if(req.params.indicator!=='favicon.ico')
//     {
//           db.all("select distinct City,Country from customers",
//           req.params.indicator,
//           function(err, row)
//             {
//             if(err) {throw err;}
//
//             fs.writeFile("./cities.json",JSON.stringify(row),function(e)
//               {
//               console.log("cities written!")
//               });
//             });
//     };
// });


// Get geolocational codes from Google Geocoding API
// fs.readFile("./cities.json",function(e,data)
// {
//   var cities = JSON.parse(data);
//
//   app.get('/geocoding',function(req, res)
//     {
//     if(req.params.indicator!=='favicon.ico')
//       {
//
//       for(i=0;i<cities.length;i++)
//         {
//           var url3 = "https://maps.googleapis.com/maps/api/geocode/json?address="+cities[i].City.replace(" ","+")+","+cities[i].Country.replace(" ","+")+"&key=AIzaSyCUDbbdZqgnvYm0LmOJAXlm_lJKTOERRYg";
//
//             request(url3, function(error, response, body)
//             {
//               if(!error && response.statusCode === 200)
//                 {
//                   var data = JSON.parse(body);
//                   console.log(data);
//                   array.push(data);
//                 };
//             });
//           };
//
//
//
//
//       fs.writeFile("./dummy.json",JSON.stringify(array),function(e)
//       {
//         console.log("cities geocoded!")
//       });
//
//       };
//     });
//
// });




var server = app.listen(4000,function()
{
  console.log("listening on port 4000")
});
