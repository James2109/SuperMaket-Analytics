--create database Meki
--use Meki

--ALTER TABLE dim_customer
--ALTER COLUMN customer_id int

select * from dim_customer
where customer_id in
(select customer_id from Sale_data
where transaction_date >= '01/11/2021' and customer_id not in
(select customer_id from Sale_data
where transaction_date < '01/11/2021')
group by customer_id)
order by customer_id

select * from dim_customer
where customer_id not in
(select customer_id from Sale_data
where transaction_date >= '01/11/2021' and customer_id not in
(select customer_id from Sale_data
where transaction_date < '01/11/2021')
group by customer_id)
or customer_id not in
(select customer_id from Sale_data
where transaction_date >= '01/05/2021' and customer_id in
(select customer_id from Sale_data
where transaction_date < '01/05/2021')
group by customer_id
having count(distinct transaction_id) >= 9)

select customer_id, count(distinct transaction_id) from Sale_data
where customer_id in
(select customer_id from Sale_data
where transaction_date >= '01/05/2021' and customer_id in
(select customer_id from Sale_data
where transaction_date < '01/05/2021'))
group by customer_id
having count(distinct transaction_id) >= 12

select * from dim_customer
where customer_id in
(select customer_id from Sale_data
where transaction_date >= '01/05/2021' and customer_id in
(select customer_id from Sale_data
where transaction_date < '01/05/2021')
group by customer_id
having count(distinct transaction_id) >= 9)
order by customer_id


select  AVG(count_of_transaction) from
(select customer_id, count(distinct transaction_id) as count_of_transaction from Sale_data
group by customer_id) as A

