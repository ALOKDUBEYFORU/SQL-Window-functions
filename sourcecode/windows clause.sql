
'''
**Note: Try to avoid *GROUP BY* clause to solve the problems**

For the problems use the *Health Insurance Claim* dataset. You can get the details as well as the dataset from [here](https://www.kaggle.com/datasets/thedevastator/insurance-claim-analysis-demographic-and-health).

### **Problem 1:** What are the top 5 patients who claimed the highest insurance amounts?

'''

Select *,sum(claim) over(partition by patientid order by claim desc) claim_sum
from training.Insurance_data
order by claim_sum desc limit 5;

'''
### **Problem 2:** What is the average insurance claimed by patients based on the number of children they have?
'''

SELECT *,avg(claim) over(partition by children) FROM training.insurance_data  

'''
### **Problem 3:** What is the highest and lowest claimed amount by patients in each region?
'''
select *,first_value(claim) over(partition by region order by claim desc) 'Highest Amount',
first_value(claim) over(partition by region order by claim ) 'Lowest Amount' 
from training.insurance_data ;

'''
### **Problem 4:** What is the percentage of smokers in each age group?
'''

Select *, 
count(smoker) over (partition by age,smoker)*100/count(smoker) over (partition by age) 'smoker percentage'
from training.insurance_data

'''
### **Problem 5:** What is the difference between the claimed amount of each patient and the first claimed amount of that patient?
'''

SELECT *,sum(claim) over()  - claim as "Diff between claimed amount"
FROM training.insurance_data


'''
### **Problem 6:** For each patient, calculate the difference between their claimed amount 
and the average claimed amount of patients with the same number of children.
'''
select *,
sum(claim) over (partition by patientid) as "Claim by a patient id", 
round(avg(claim) over (partition by children),2) as "Avg Claim by patients with same no of children",
round(sum(claim) over (partition by patientid) - avg(claim) over (partition by children),2) as "Difference of Claims"
from training.insurance_data 


'''
### **Problem 7:** Show the patient with the highest BMI in each region and their respective rank.
'''
Select *,
rank() over (partition by region order by bmi desc) "rank in the region",
dense_rank() over (partition by region order by bmi desc) "Dense Rank in the region" 
from training.insurance_data 

'''
### **Problem 8:** Calculate the difference between the claimed amount of each patient 
and the claimed amount of the patient who has the highest BMI in their region.
'''
select * ,
first_value(claim) over (partition by region order by bmi desc) "claim amount of the patient with highest bmi in the region",
claim - first_value(claim) over (partition by region order by bmi desc) "Difference"
From training.insurance_data 

'''
### **Problem 9:** For each patient, calculate the difference in claim amount between the patient and 
the patient with the highest claim amount among patients with the same bmi and smoker status, within the same region. 
Return the result in descending order difference.
'''
Select *, 
first_value(claim) over (partition by bmi,smoker,region order by claim desc) 'patient with highest claim amount',
claim - first_value(claim) over (partition by bmi,smoker,region order by claim desc) 'difference of claim amount'
from training.insurance_data 
order by 'difference of claim amount' Desc 

'''
### **Problem 10:** For each patient, find the maximum BMI value among their next three records (ordered by age).
'''
select *,
first_value(bmi) over ( order by bmi desc rows between current row and 3 following) as "3rd row"
from training.insurance_data 
order by bloodpressure,bmi

'''
### **Problem 11:** For each patient, find the rolling average of the last 2 claims.
'''
select *,
lag(claim,1) over () as 'lag of last row',
lag(claim,2) over () as 'lag of last but one row',
(lag(claim,1) over () +lag(claim,2) over () )/2 as 'lag average'
from training.insurance_data 

'''
### **Problem 12:** Find the first claimed insurance value for male and female patients, 
within each region order the data by patient age in ascending order, 
and only include patients who are non-diabetic and have a bmi value between 25 and 30.
'''

Select * ,
first_value(claim) over(partition by gender,region order by age)
from training.insurance_data 
where diabetic = 'No' and bmi between 25 and 30