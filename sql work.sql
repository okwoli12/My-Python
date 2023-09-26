1.-- what channel make the highest sales?

select w.channel, sum(o.total) as "total"
from "order_table" as o
join "web_events" as w
on o.account_id =  w.account_id
group by w.channel
order by "total" desc;

2.-- which company  generated the high sales with what channel?
select a.name, w.channel, sum(o.total_amt_usd) as "tot_sales_usd"
from "order_table" as o
join "web_events" as w
on o.account_id =  w.account_id
join "accounts" as a
on w.account_id = a.id
group by a.name, w.channel
order by "tot_sales_usd" desc;

3.-- the company with the highest profit starting with c
select a.name, w.channel, sum(o.total_amt_usd) as "tot_sales_usd"
from "order_table" as o
join "web_events" as w
on o.account_id =  w.account_id


join "accounts" as a
on w.account_id = a.id
where a.name like 'C%'
group by a.name, w.channel
order by "tot_sales_usd" desc;

4.-- the company with the highest profit fior anywhere there is I
select a.name, w.channel, sum(o.total_amt_usd) as "tot_sales_usd"
from "order_table" as o
join "web_events" as w
on o.account_id =  w.account_id
join "accounts" as a
on w.account_id = a.id
where a.name like '%I%'
group by a.name, w.channel
order by "tot_sales_usd" desc;

5.-- which sales rep have the highest sales in the northeast region
select s.name, sum(o.total) as "total"
from "accounts" as a
join "order_table" as o
on a.id = o.account_id
join "sales_rep" as s
on a.sales_rep_id = s.id
join "region" as r
on s.region_id = r.id
where r.name = 'Northeast'
group by s.name
order by "total" desc;

6.-- which sales rep has the customer base
select s.name, count(a.name) as "amount"
from "accounts" as a 
join "sales_rep" as s
on a.sales_rep_id = s.id
group by s.name
order by "amount" desc

-- which region has the most revenue by direct channel
select r.name, sum(o.total_amt_usd) as  "tot_rev"
from "accounts" a
join "order_table" o 
on a.id= o.account_id
join "web_events" as w
on o.account_id = w.account_id
join "sales_rep" as s
on a.sales_rep_id = s.id
join "region" as r
on s.region_id = r.id
where w.channel = 'direct'
group by r.name
order by "tot_rev" desc

-- which account  had the highest transaction in midwest through organic channel?
select a.name, sum(o.total) as "total_trans"
from "accounts" a
join "order_table" o
on a.id =  o.account_id
join "web_events" as w
on o.account_id = w.account_id
join "sales_rep" s
on a.sales_rep_id = s.id
join "region" r
on s.region_id = r.id
where w.channel = 'organic' and r.name = 'Midwest'
group by a.name
order by "total_trans" desc; 

-- which channel is more popular in the northeast 
select w.channel, count(w.channel)as "total_trans"
from "accounts" a
join "web_events" w
on a.id = w.account_id
join "sales_rep" s
on a.sales_rep_id = s.id
join "region" r
on s.region_id = r.id
where r.name = 'Northeast'
group by w.channel
order by "total_trans" ;

-- what channel make the highest sales?
select w.channel, sum(total) as "total"
from "order_table" o
join "web_events" w
on o.account_id = w.account_id
group by w.channel
order by "total"

-- 2.-- which company  generated the high sales with what channel?
select a.name, w.channel, sum(o.total) as "total_sales_usd"
from "order_table" o
join "web_events" w
on o.account_id = w.account_id
join "accounts" a
on w.account_id = a.id
group by a.name, w.channel
order by "total_sales_usd" desc;

-- CLASS WORK
-- 1.which region do most of our sales rep com from
-- 2.which company made the lowes sales and what was the most channel they use
-- 3.find out the company that made the highest final total and the salesrep responsible
-- 4. which company has had the highrst reach using facebook
answer
--  1.which region do most of our sales rep com from
select r.name, count(r.name) as "location"
from "sales_rep" s
join "region" r
on s.region_id = r.id
group by r.name
order by "location"

--2. company that made the lowest sales and thier POC responsible
select a.name, a.primary_poc, sum(o.total_amt_usd) as "total_sales"
from "accounts" a
join "order_table" o
on a.id = o.account_id
join "sales_rep" s
on a.sales_rep_id = s.id
group by a.name, a.primary_poc
order by "total_sales"
limit 5
-- 3.find out the company that made the highest final total and the salesrep responsible
select a.name, s.name, sum(o.total_amt_usd) as "total_sales"
from "accounts" a
join "order_table" o
on a.id = o.account_id
join "sales_rep"s
on a.id = s.id
group by a.name, s.name
order by "total_sales" 

--  4. which company has had the highrst reach using facebook



ASSIGNMENT
-- 1companies that has the highest sales through facebook 
-- 2companies that has the highest sales accross all sales channel
-- 3on average for the sales channel which company had total amount usd

-- the company that has the highest sales through facebook
select a.name, w.channel, count(w.channel) as "channel_count"
from "accounts" a
join "web_events" w
on a.id = w.account_id
where w.channel = 'facebook'
group by a.name, w.channel
order by "channel_count" desc;


-- 2companies that has the highest sales accross all sales channel
select a.name, w.channel sum(o.total) as "total_sales"
from "accounts" a
join "web_events" w
on a.id = w.account_id
join "order_table" o
on a.id = o.account_id
group by a.name, w.channel
order by "total_sales"


-- 3on average for the sales channel which company had total amount usd
select w.channel, a.name, avg(o.total_amt_usd) as "avg_value"
from "accounts" a
join "web_events" w
on a.id =w.account_id
join "order_table"o
on a.id = o.account_id
group by w.channel, a.name
order by "avg_value"
