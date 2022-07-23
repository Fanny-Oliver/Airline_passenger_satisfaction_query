--to get the number of male and female customers
SELECT 
 Gender,
 COUNT (Gender) AS count_of_gender
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Gender