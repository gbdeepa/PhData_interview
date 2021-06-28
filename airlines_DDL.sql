

create schema airlines;

create table airlines
(IATA_CODE String comment 'Airline Identifier',
AIRLINE String comment 'Airline name');

create table airports 
(IATA_CODE String comment 'Airline identifier',
AIRPORT String comment 'Airport name',
CITY String comment 'City where the airport is located',
STATE String comment 'State where the airport is located',
COUNTRY String comment 'The country where the airport is located',
LATITUDE Number comment 'Latitude of the airport',
LONGITUDE Number comment 'Longitude of the airport');


create table flights
 (YEAR	Number	comment	'Year of the flight',
MONTH	Number	comment	'The month of the flight',
DAY	Number	comment	'The day of the flight',
DAY_OF_WEEK	Number	comment	'Day of the week of the flight',
AIRLINE	String	comment	'Airline identifier',
FLIGHT_NUMBER	String	comment	'Flight identifier',
TAIL_NUMBER	String	comment	'Aircraft identifier',
ORIGIN_AIRPORT	String	comment	'Starting airport',
DESTINATION_AIRPORT	String	comment	'Destination airport',
SCHEDULED_DEPARTURE	String	comment	'Planned departure time',
DEPARTURE_TIME	String	comment	'Wheels up time',
DEPARTURE_DELAY	Number	comment	'Total delay on departure',
TAXI_OUT	Number	comment	'The time duration elapsed between departure from the origin airport gate and wheels off',
WHEELS_OFF	String	comment	'The time point that the aircraft\'s wheels leave the ground',
SCHEDULED_TIME	Number	comment	'Planned time amount needed for the flight trip',
ELAPSED_TIME	Number	comment	'Total trip time',
AIR_TIME	Number	comment	'The time duration between wheels_off and wheels_on time',
DISTANCE	Number	comment	'The distance between two airports',
WHEELS_ON	Number	comment	'The time point that the aircraft\'s wheels touch on the ground',
TAXI_IN	Number	comment	'The time duration elapsed between wheels-on and gate arrival at the destination airport',
SCHEDULED_ARRIVAL	Number	comment	'Planned arrival time',
ARRIVAL_TIME	String	comment	'Time of arrival',
ARRIVAL_DELAY	String	comment	'Arrival time - Scheduled Arrival',
DIVERTED	Number	comment	'Aircraft was diverted',
CANCELLED	Number	comment	'Aircraft was canceled',
CANCELLATION_REASON	String	comment	'Reason for Cancellation of flight: A - Airline/Carrier; B - Weather; C - National Air System; D - Security',
AIR_SYSTEM_DELAY	Number	comment	'Delay caused by the air system',
SECURITY_DELAY	Number	comment	'Delay caused by security',
AIRLINE_DELAY	Number	comment	'Delay caused by the airline',
LATE_AIRCRAFT_DELAY	Number	comment	'Delay caused by the aircraft',
WEATHER_DELAY	Number	comment	'Delay caused by weather'
);
