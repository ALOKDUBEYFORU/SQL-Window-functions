Select * from training.Insurance_data;
# displays the total claim amount along with all the rows
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


'''
**Note: Try to avoid *GROUP BY* clause to solve the problems**

For the problems use the *Health Insurance Claim* dataset. You can get the details as well as the dataset from [here](https://www.kaggle.com/datasets/thedevastator/insurance-claim-analysis-demographic-and-health).

### **Problem 1:** What are the top 5 patients who claimed the highest insurance amounts?

'''

Select *,sum(claim) over(partition by patientid order by claim desc) claim_sum
from training.Insurance_data
order by claim_sum desc limit 5;

select * from training.insurance_data where patientid = 1338

'''
### **Problem 2:** What is the average insurance claimed by patients based on the number of children they have?

### **Problem 3:** What is the highest and lowest claimed amount by patients in each region?

### **Problem 4:** What is the percentage of smokers in each age group?

### **Problem 5:** What is the difference between the claimed amount of each patient and the first claimed amount of that patient?

### **Problem 6:** For each patient, calculate the difference between their claimed amount and the average claimed amount of patients with the same number of children.

### **Problem 7:** Show the patient with the highest BMI in each region and their respective rank.

### **Problem 8:** Calculate the difference between the claimed amount of each patient and the claimed amount of the patient who has the highest BMI in their region.

### **Problem 9:** For each patient, calculate the difference in claim amount between the patient and the patient with the highest claim amount among patients with the same bmi and smoker status, within the same region. Return the result in descending order difference.

### **Problem 10:** For each patient, find the maximum BMI value among their next three records (ordered by age).

### **Problem 11:** For each patient, find the rolling average of the last 2 claims.

### **Problem 12:** Find the first claimed insurance value for male and female patients, within each region order the data by patient age in ascending order, and only include patients who are non-diabetic and have a bmi value between 25 and 30.
'''