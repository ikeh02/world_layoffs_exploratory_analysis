-- Exploatory Data Analysis
-- of a worlds company's data that shows various companies their total laid off staffs, the percentage, their funds raised in millions and many others

select *
from layoff_learner2;

-- Found the maximum total laid off staffs

select  max(total_laid_off)
from layoff_learner2;

-- Found the maximum total laid off and percentage laid off staffs

select  max(total_laid_off), max(percentage_laid_off)
from layoff_learner2;

-- checked for companies who laid off 100 percent of their staffs

select *
from layoff_learner2
where percentage_laid_off = 1;

-- checked for top five companies who laid off 100 percent of their staffs with companies with highest amount of lay offs

select *
from layoff_learner2
where percentage_laid_off = 1
order by total_laid_off desc
limit 5;

-- checked for top five companies who laid off 100 percent of their staffs with companies with companies that generated highest amount of funds 


select *
from layoff_learner2
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- Found each company's sum of total laid off of their staffs 

select company, sum(total_laid_off)
from layoff_learner2
group by company
order by 2 desc;

-- Found the range dates which is over 2 years and 7 months

select min(`date`), max(`date`)
from layoff_learner2;

--  Found each county's sum of total laid off while displaying the countries with the highest staffs laid off 

select country, sum(total_laid_off)
from layoff_learner2
group by country
order by 2 desc;

-- Found each company's highest or max laid off 

select  company, max(total_laid_off) as max_laid_off
from layoff_learner2
where total_laid_off is not null
group by company
order by 2 desc;

-- Found each years  sum of  total laid off
select year(`date`), sum(total_laid_off)
from layoff_learner2
group by year(`date`)
order by 1 desc;


-- Found each stage sum of total laid off

select stage, sum(total_laid_off)
from layoff_learner2
group by stage
order by 1 desc;

-- Found each month of the year's sum of total laid off

select substr(`date`, 6,2) as `month`,  sum(total_laid_off) as sum_total
from layoff_learner2
group by `month`
order by `month` asc
;

-- Found the total sum of the year and the month and not adding the nulls while grouping the sums by year and month

select substr(`date`, 1,7) as `month`, sum(total_laid_off)
from layoff_learner2
where substr(`date`, 1,7) is not null
group by `month`
order by 1 asc
;

-- Found the rolling sum of total laid off for each year and month by using a cte example

with rolling_total as 
(
select substr(`date`, 1,7) as `month`, sum(total_laid_off) as total_off
from layoff_learner2
where substr(`date`, 1,7) is not null
group by `month`
order by 1 asc
)select `month`, 
total_off, sum(total_off) over ( order by `month` ) as rolling_total
 from rolling_total ; 
 
 -- Found each  company's sum total_laid_off
 
 select company, sum(total_laid_off)
from layoff_learner2
group by company
order by  2 desc;

--  Found each  company's sum total_laid_off and the year and ordered it by the third column
 
select company, year(`date`) as `year`, sum(total_laid_off)
from layoff_learner2
group by company,  year(`date`)
order by  3 desc;

-- use cte to find each  company's  sum total_laid_off and the year and ordered it by the third column

with company_year (company , years , total_laid_off)  as 
(
select company, year(`date`), sum(total_laid_off) 
from layoff_learner2
group by company,  year(`date`)
order by  3 desc 
)
select *
from company_year;

-- Used cte to partition  ranks by years and ordered by the highest total_laid_off using dense rank

with company_year (company , years , total_laid_off)  as 
(
select company, year(`date`), sum(total_laid_off) 
from layoff_learner2
group by company,  year(`date`)
order by  3 desc 
)
select*, dense_rank () over (partition  by years order by total_laid_off desc) as Ranking
from company_year
where years is not null
order by ranking;

-- Here used two ctes to get the first to fifth companies with the highest total laid of each year
with company_year (company , years , total_laid_off)  as 
(
select company, year(`date`), sum(total_laid_off) 
from layoff_learner2
group by company,  year(`date`)
order by  3 desc 
), 
company_year_rank as
(
select*, dense_rank () over (partition  by years order by total_laid_off desc) as Ranking
from company_year
where years is not null
)
select *
from company_year_rank
where Ranking <= 5
;


with company_year (company , years , total_laid_off)  as 
(
select company, year(`date`), sum(total_laid_off) 
from layoff_learner2
group by company,  year(`date`)
order by  3 desc 
)
select*, dense_rank () over (partition  by years order by total_laid_off desc) as Ranking
from company_year
where years is not null
order by ranking;


with company_year (company , years , total_laid_off)  as 
(
select company, year(`date`), sum(total_laid_off) 
from layoff_learner2
group by company,  year(`date`)
order by  3 desc 
), 
company_year_rank as
(
select*, dense_rank () over (partition  by years order by total_laid_off desc) as Ranking
from company_year
where years is not null
)
select *
from company_year_rank
where Ranking <= 5
order by ranking;


select *
from layoff_learner2;


select company,industry, sum(total_laid_off)
from layoff_learner2
group by company, industry
order by 3 desc;

with industry_rank as
(
select company,industry, sum(total_laid_off) as total_laid_off
from layoff_learner2
group by company, industry
order by 3 desc
)
select*, dense_rank () over (partition by industry order by total_laid_off desc) as Ranking
from industry_rank
order by ranking ;


with industry_rank as
(
select company,industry, sum(total_laid_off) as total_laid_off
from layoff_learner2
group by company, industry
order by 3 desc
), Ind_ranking as
(
select*, dense_rank () over (partition by industry order by total_laid_off desc) as Ranking
from industry_rank
order by ranking 
)
select*
from Ind_ranking
where ranking <= 5;

-- Getting the months of each year in which 100percent of staffs where laid off
select company, total_laid_off, percentage_laid_off ,substr(`date`, 1,7) as `month`
from layoff_learner2
where percentage_laid_off = 1;

with bad_month as
(
select company, total_laid_off, percentage_laid_off ,substr(`date`, 1,7) as `month`
from layoff_learner2
where percentage_laid_off = 1
), worse_month as
(
select *, 
row_number () over (partition by company order by total_laid_off desc) as row_no
from bad_month
)
select*
from  worse_month
where row_no = 1;

-- Finding the Single "Worst Month" for Every Company

-- Step 1: Sum up total layoffs per company per month
select company, substring(`date`, 1,7) as `month`, sum( total_laid_off ) as total_off
from layoff_learner2
where substring(`date`, 1,7) is not null
group by company , `month`
order by 3 desc;

with bad_month as
(
select company, substring(`date`, 1,7) as `month`, sum( total_laid_off ) as total_off
from layoff_learner2
where substring(`date`, 1,7) is not null
group by company , `month`
order by 3 desc
), worse_month as
(
 -- Step 2: Rank the months from highest layoffs to lowest for each company
select *, 
row_number() over (partition by company order by total_off desc) as row_num
from bad_month
)
-- Step 3: Keep only the worst month (Rank 1)
select company , `month`, total_off
from worse_month
where row_num = 1;

select company, year(`date`) as years, sum(total_laid_off) as total_hat
from layoff_learner2
where year(`date`) is not null 
and total_laid_off is not null
group by company, `year`
order by 3 desc;
 -- getting the layoffs percentages
with company_yearly as (
    -- Step 1: Get the total layoffs for each company per year
    select company, year(`date`) as years, sum(total_laid_off) as company_layoffs
    from layoff_learner2
    where year(`date`) is not null and total_laid_off is not null
    group by company, year(`date`)
)
select 
    company, 
    years, 
    company_layoffs,
    
    -- Step 2: Get the total for the ENTIRE year using OVER() without ORDER BY
    sum(company_layoffs) over (partition by years) as total_year_layoffs,
    
    -- Step 3: Divide the part by the whole to get the percentage
    (company_layoffs / sum(company_layoffs) over (partition by years)) * 100 as layoff_percentage

from company_yearly
order by years desc, layoff_percentage desc;


SELECT 
    company, 
    substr(`date`, 1,4) as `date`,
   total_laid_off,
    SUM(total_laid_off) OVER (order by `date`) AS total_company_payroll
 from layoff_learner2
 where `date` is not null
 group by company, `date`, location, total_laid_off ;
 
SELECT 
   distinct company, 
    substr(`date`, 1,4) as `date`,
   total_laid_off,
  dense_rank() over(order by total_laid_off desc) as ranking
 from layoff_learner2
 where `date` is not null
 limit 3
 ;



select*
 from layoff_learner2 
 order by 4 desc
 ;


