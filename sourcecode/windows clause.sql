
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



'''
### **Problem 6:** For each patient, calculate the difference between their claimed amount and the average claimed amount of patients with the same number of children.

### **Problem 7:** Show the patient with the highest BMI in each region and their respective rank.

### **Problem 8:** Calculate the difference between the claimed amount of each patient and the claimed amount of the patient who has the highest BMI in their region.

### **Problem 9:** For each patient, calculate the difference in claim amount between the patient and the patient with the highest claim amount among patients with the same bmi and smoker status, within the same region. Return the result in descending order difference.

### **Problem 10:** For each patient, find the maximum BMI value among their next three records (ordered by age).

### **Problem 11:** For each patient, find the rolling average of the last 2 claims.

### **Problem 12:** Find the first claimed insurance value for male and female patients, within each region order the data by patient age in ascending order, and only include patients who are non-diabetic and have a bmi value between 25 and 30.
'''