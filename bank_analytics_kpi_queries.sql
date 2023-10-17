-- create database bank_analytics;

-- I imported finance_1 and finance_2 tables from mysql table import wizard by correcting the datatypes in  CSV files and removing the unwanted data and errors.
use bank_analytics;
select * from finance_1;
select * from finance_2;

-- Q.1 Year-wise loan amount stats

select year(issue_d), sum(loan_amnt) 
from finance_1
group by year(issue_d)
order by year(issue_d);

-- Q.2 Grade and Subgradeiwise revolving balance

select finance_1.grade, finance_1.sub_grade, sum(finance_2.revol_bal)
from finance_1
inner join finance_2 on
finance_1.id = finance_2.id
group by grade, sub_grade
order by grade;
 
 -- Q.3 Total Payment for Verfified status vs total payment for Non-verfified status
 
 select finance_1.verification_status, sum(total_pymnt)
 from finance_1
 inner join finance_2 on
 finance_1.id = finance_2.id
 group by finance_1.verification_status;
 
-- Q.4 Status-wise and month-wise loan status

select addr_state as State, year(issue_d), monthname(issue_d) as Month_of_year, sum(loan_amnt)
from finance_1
group by addr_state, year(issue_d),  monthname(issue_d)
order by year(issue_d);

-- Q.5 Home ownership vs Last payment date stats

select finance_1.home_ownership, sum(finance_2.last_pymnt_amnt) as last_payment_amount, finance_2.last_pymnt_d
from finance_1
inner join finance_2 on
finance_1.id = finance_2.id
group by home_ownership, last_pymnt_d
order by last_pymnt_d
