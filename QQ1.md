select r.manager, r.region_name, sum(s.sales) as total_sales
from sales s join regional_manager r 
on s.region= r.region_name
group by 1,2
order by 3 Desc
limit 1;