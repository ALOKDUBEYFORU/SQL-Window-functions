#This is an introduction to windows functions in sql

#To display all the records of the insurance_data table

Select * from training.Insurance_data;

# displays the total claim amount made by all along with all the rows

select *,sum(claim) over() as 'claim_sum' from training.insurance_data order by claim_sum desc;

# display the total claim amount against each gender

select *,sum(claim) over(partition by gender) from training.insurance_data order by claim desc

# rounding off the total claim amount to two digits

Select *, round(avg(claim) over (partition by gender),2) as "total_claim_amount" from training.insurance_data order by claim desc;

#ranking the records based on the claim amount 

select *, rank() over(order by claim desc,gender desc) 'rank_patient' from training.insurance_data ;

#dense rank
select *, dense_rank() over(order by bmi desc,gender desc) 'rank_patient' from training.insurance_data ;

# row number

select *, row_number() over(partition by diabetic,smoker ) "row_num" from training.insurance_data

# row number 
select *, row_number() over(partition by diabetic,smoker order by bmi desc) "row_num" from training.insurance_data;

#first_value
select *, first_value(claim) over() "row_num" from training.insurance_data;

# first_value
select *, first_value(claim) over(partition by gender order by bmi desc) "row_num" from training.insurance_data;

#last_value
select *, last_value(claim) over(partition by gender order by claim desc rows between unbounded preceding and unbounded following) "row_num" from training.insurance_data;

#nth value 
select *, nth_value(claim,3) over(partition by gender order by claim desc rows between unbounded preceding and unbounded following) "row_num" from training.insurance_data;
