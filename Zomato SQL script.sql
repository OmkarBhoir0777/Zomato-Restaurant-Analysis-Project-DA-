Create database zomata_Sales_Analysis;
Use zomata_Sales_Analysis;
UPDATE zomata_sales_analysis SET Datekey_Opening = REPLACE(Datekey_Opening, '-', '/') WHERE Datekey_Opening LIKE '%_%';
alter table zomata_sales_analysis modify column Datekey_Opening date;

select * from zomata_sales_analysis;


#2.
select year(Datekey_Opening) years,
month(Datekey_Opening)  months,
day(datekey_opening) day ,
monthname(Datekey_Opening) monthname,
Quarter(Datekey_Opening)as quarter,
concat(year(Datekey_Opening),'-',monthname(Datekey_Opening)) yearmonth, 
weekday(Datekey_Opening) weekday,
dayname(datekey_opening)dayname, 

case when monthname(datekey_opening) in ('January' ,'February' ,'March' )then 'Q1'
when monthname(datekey_opening) in ('April' ,'May' ,'June' )then 'Q2'
when monthname(datekey_opening) in ('July' ,'August' ,'September' )then 'Q3'
else  'Q4' end as quarters,

case when monthname(datekey_opening)='January' then 'FM10' 
when monthname(datekey_opening)='January' then 'FM11'
when monthname(datekey_opening)='February' then 'FM12'
when monthname(datekey_opening)='March' then 'FM1'
when monthname(datekey_opening)='April'then'FM2'
when monthname(datekey_opening)='May' then 'FM3'
when monthname(datekey_opening)='June' then 'FM4'
when monthname(datekey_opening)='July' then 'FM5'
when monthname(datekey_opening)='August' then 'FM6'
when monthname(datekey_opening)='September' then 'FM7'
when monthname(datekey_opening)='October' then 'FM8'
when monthname(datekey_opening)='November' then 'FM9'
when monthname(datekey_opening)='December'then 'FM10'
end Financial_months,
case when monthname(datekey_opening) in ('January' ,'February' ,'March' )then 'FQ4'
when monthname(datekey_opening) in ('April' ,'May' ,'June' )then 'FQ1'
when monthname(datekey_opening) in ('July' ,'August' ,'September' )then 'FQ2'
else  'FQ3' end as financial_quarters
from zomata_sales_analysis;


/*3.Find the Numbers of Resturants based on City and Country.*/

select CountryCode,
city,count(ï»¿RestaurantID)no_of_restaurants
from zomata_sales_analysis
group by CountryCode ,city;

#4.Numbers of Resturants opening based on Year , Quarter , Month.

select year(datekey_opening)year,quarter(datekey_opening)quarter,monthname(datekey_opening)monthname,
count(ï»¿RestaurantID)as no_of_restaurants 
from zomata_sales_analysis group by year(datekey_opening),quarter(datekey_opening),monthname(datekey_opening) 
order by year(datekey_opening),quarter(datekey_opening),monthname(datekey_opening) ;

#5. Count of Resturants based on Average Ratings.

select case when rating <=2 then "0-2" when rating <=3 then "2-3" when rating <=4 then "3-4" when Rating<=5 then "4-5" end rating_range,
count(ï»¿RestaurantID) 
from zomata_sales_analysis
group by rating_range 
order by rating_range;

#6. Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

select price_range,
count(ï»¿RestaurantID)
from zomata_sales_analysis
group by price_range
order by Price_range;

#7.Percentage of Resturants based on "Has_Table_booking"

select has_table_booking,concat(round(count(has_table_booking)/100,0),"%") percentage 
from zomata_sales_analysis
group by has_table_booking;


#8.Percentage of Resturants based on "Has_Online_delivery"

select has_online_delivery,concat(round(count(Has_Online_delivery)/100,0),"%") percentage 
from zomata_sales_analysis
group by has_online_delivery;

#9. Develop Charts based on Cusines, City, Ratings
Select Cuisines, SUBSTRING_INDEX(cuisines, ',', 1) AS cuisine1,
SUBSTRING_INDEX(SUBSTRING_INDEX(cuisines, ',', 2), ',', -1) AS cuisine2,
SUBSTRING_INDEX(SUBSTRING_INDEX(cuisines, ',', 3), ',', -1) AS cuisine3, 
City, Rating
From zomata_sales_analysis;