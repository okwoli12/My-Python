select * 
from "order_table";

-- week day extraction
select *,
case when "weekday" = 1 then 'monday'
	when "weekday" = 2 then 'tuesday'
	when "weekday" = 3 then 'wednesday'
	when "weekday" = 4 then 'thursday'
	when "weekday" = 5 then 'friday'
	when "weekday" = 6 then 'saturday'
else 'sunday' end as "week_days"
from 
(select *, extract(dow from "occurred_at") as "weekday"
from "order_table") as "table_one;"

-- which weekday had the total sales in amt_usd
select "week_days", sum("total_amt_usd") as "total_val"
from 
(select *,
case when "weekday" = 1 then 'monday'
	when "weekday" = 2 then 'tuesday'
	when "weekday" = 3 then 'wednesday'
	when "weekday" = 4 then 'thursday'
	when "weekday" = 5 then 'friday'
	when "weekday" = 6 then 'saturday'
else 'sunday' end as "week_days"
from 
(select *, extract(dow from "occurred_at") as "weekday"
from "order_table") as "table_one) as "table_two";
group by "week_days"
order by "total_val" desc;
-- max sales made by each company
select a.name, max("total_amt_usd") as "sales_max", sum(total_amt_usd) as "sales_sum"
from "accounts"a
join "order_table"o
on a.id = o.account_id
group by a.name;

-- max sales and summ sales made by each company
select a.name, max("total_amt_usd") as "sales_max", sum("total_amt_usd") as "total_sum"
from "accounts" a
join "order_table"o
on a.id = o.account_id
group by a.name
-- company with the highets sum sales
select a.name "company",  sum("total_amt_usd") as "sales_sum"
from "accounts" a
join "order_table" o
on a.id = o.account_id
group by a.name
order by "sales_sum" desc;

insert into "sales_vals" ("company_name","max_sales", "total_sales")
select a.name, max("total_amt_usd") as "sales_max",  sum("total_amt_usd") as "sales_sum"
from "accounts" a
join "order_table" o
on a.id = o.account_id
group by a.name
order by "sales_sum" desc;

Alter table "order_table"
Alter column "occurred_at" type Date using "occurred_at":: Date
