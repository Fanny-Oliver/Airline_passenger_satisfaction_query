--to find the percentage of customers that are satisfied:
SELECT COUNT(Satisfaction) AS total_satisfaction_number, 
  (
    (SELECT COUNT (Satisfaction)
    FROM `my-maven-projects.Airline_data.Passenger_satisfaction`  
    WHERE Satisfaction = "Satisfied")
  ) 
  AS satisfied_num,
ROUND ((SELECT COUNT (Satisfaction) FROM `my-maven-projects.Airline_data.Passenger_satisfaction` WHERE Satisfaction = "Satisfied")/COUNT(Satisfaction)*100, 2) AS satisfied_percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction` 