--to find the customer profile of a repeating airline passenger
SELECT Gender, Type_of_Travel AS travel_type, Class AS class_type,
MIN(Age) AS min_age,
MAX(Age) AS max_age
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
WHERE Customer_Type = 'Returning'
GROUP BY Gender, Type_of_Travel, Class
ORDER BY Gender