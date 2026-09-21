create database public_transport;

-- 1. Top 10 routes 
select route_name,count(*) as route_count
from transport_table 
group by route_name
ORDER BY route_count DESC
limit 10 ;
--  2. Average delay

select avg(delay_minutes)as avg_delay
from transport_table ;

-- 3. Monthly passenger growth
with Monthly
 as(
select month, 
sum(passengers) as total_passenger
from transport_table
group by month
)
select month , total_passenger ,
             round(
             (
             total_passenger - LAG(total_passenger) over(order by month)
             )
             / LAG(total_passenger) over(order by month) *100,2
             ) as growth_percentage
             from Monthly
             order by month;

-- 4.  Route utilization
 select route_name,utilization_category , utilization_rate from transport_table
 where utilization_category = "High"
 order by  utilization_rate;


-- Cancellation rate
-- Peak-hour demand
-- Route ranking
-- Month-over-month growth