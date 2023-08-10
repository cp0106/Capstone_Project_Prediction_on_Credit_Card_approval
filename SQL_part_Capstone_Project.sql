#It is a part of Capstone Project the Queries should be answered in MySQL.
# The Clean Data is derived after the all necessary steps after Data munging.
# Here we have merged both of the data which is given for problem statement (Credit_card and Credit_card_label)
# Data has all records of customer whose Credit Aprroval has been accepted or rejected by the Bank which is denoted as 0 = accepted and 1 = rejected in the column called label.

SELECT * FROM credit_card.credit_data_clean;
use credit_card;

ALTER TABLE credit_data
RENAME COLUMN MyUnknownColumn TO Sr_Nr;

# Q.1 Group the customers based on their income type and find the average of their annual income.

select type_income ,round(avg(annual_income),2) from credit_data 
group by type_income;

# Q.2 Find the female owners of cars and property.
-- total 155 Female Customers are having car and propert.

select * from credit_data
where gender = 'F' and car_owner  = 'y' and propert_owner = 'y';

# Q.3 Find the male customers who are staying with their families.
select distinct(marital_status) from credit_data;
-- as we remove the children columns from dataset we can take a condition like more than 2 family members for families (so it will inculde one couple + one child)

select * from credit_data where gender = 'M' having family_members > 2;

#Q.4 Please list the top five people having the highest income.

select * from credit_data order by annual_income desc limit 5;

#Q.5 How many married people are having bad credit?
-- total 91 customers are married (married and civil marriage) with bad credit (label as 1 as rejected)
select * from (select * from credit_data where marital_status = 'Married' or marital_status = 'Civil marriage') as a where label = 1;


#Q.6 What is the highest education level and what is the total count?
-- secondary/secondary special is the highest education in dataset

select education, count(*) as total_count from credit_data group by education order by 2 desc;

#Q.7 Between married males and females, who is having more bad credit? 
-- married women are having more bad credit (total 52 females and 39  males)
select gender, count(*) as total_count from (select * from credit_data where label = 1) as a 
where marital_status = 'Married' or marital_status = 'Civil marriage' 
group by gender order by 2 desc

#End
