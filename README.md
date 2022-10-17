**LTV Vehicles Data pipeline**

## **Getting Started**

### **Prerequisites**

1.  Install Docker for Apache Airflow

[[https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html]{.ul}](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html)

2.  Install pycharm for managing the Project (optional)

[[https://www.jetbrains.com/pycharm/download/\#section=mac]{.ul}](https://www.jetbrains.com/pycharm/download/#section=mac)

3.  Install Dbeaver (optional)

[[https://dbeaver.io/download/]{.ul}](https://dbeaver.io/download/)

### **Run locally**

        1.  Create folder for LTV project
        2.  As part of docker-compose create dag ( sql, data folders within dag folder)
        3.  docker-compose up from the command line which will bring the Docker up
        4.  Airflow login in UI (localhost:8080)
        5.  Find the Dag name that you have built and run the Tasks.

**Process Flow Diagram**

![](vertopal_27f870cf549848bebbed9c847017d4f9/media/image1.png){width="7.631419510061242in"
height="3.8097386264216975in"}

**Steps of the Process**

1)  **Source files:**

        Type of data            : csv
        Number of columns       : 21
        Expected arrival        :\<arrival time\>
        File location           :/opt/airflow/dags/data/vehicle_challenge.csv

2)  **Preprocess:**

        Code location   :dags/data_pipeline_dag.py
        Airflow Task    :source_data_check
        Checks Completed:
        Check total number of records : 
                If count is equal to zero abort the process and Send Email alert with Zero record message.
        Column count to check the Layout of the data :
                If columns of the data file are less or more than expected, Send Email alert.

3)  **Raw Layer:**

        Postgres Database       :airflow
        Postgres Schema         :public
        Audit Columns           :insert_date
        Code location           :dags/sql/create_table_sql_query.sql
        Airflow Task            :create_table
        Create source Table     :vehicles_information (21 columns)
        Create statistics Table :vehicle_statistics
        Create cleaned Table    :vehicles_deduped_information
        Create Sellerinfo Table:vehicles_seller_information
        Create final Table      :vehicles_transformed_information

4)  **Insert Raw data into Postgres Table:**

        Code location   :dags/data_pipeline_dag.py
        Airflow Task    :pg_extract_task

5)  **Check data and build statistics:**

        Postgres Database       :airflow
        Postgres Schema         :public
        Postgres statistics Table: vehicle_statistics ( 2 columns)
        Audit Column            :insert_date
        Code location           :dags/sql/check_data_sql_query.sql
        Airflow Task            :check_data
        Checks completed:
                -   Count the total number of records loaded
                -   Count the unique VINs in the data
                -   Count how many records have VIN and price
                -   Records Lost during cast conversion
                -   Top 10 of cities with the most F-150 pick-up trucks registered

6)  **Deduplicate and Cast conversion :**

        Postgres Database       :airflow
        Postgres Schema         :public
        Postgres cleaned Table :vehicles_deduped_information
        Code location           :dags/sql/deduplicate_data_sql_query.sql
        Airflow Task            :deduplicate_data
        Checks completed:
                -Removes duplicate vehicles, leaving only the record with the highest mileage
                -Cast Conversion

7)  **Transformation Layer:**

        Code location           :dags/sql/transformation_sql_query.sql
        Airflow Task            :Transformation
        Transformations completed:

            - Mileage_range    : provides which range category the Vehicles falls into.
            - Generic_fuel_type: provides Gas/Hybrid/Electric Category of Vehicles information.
            - Vehicle_status.  : 'semi-new' values are populated based on themileage.
            - Avg_miles_by_make: provides avg miles by the make and model of the vehicle.
            - Vehicle Seller Table: vehicles_seller_information (6 columns)
            (Generate an additional seller table with the name, address and amount
            of vehicles listed for this particular seller. But only for the
            sellers that list 5 or more vehicles.)

8)  **Final Load:**

            Mysql Database      :airflow
            Postgres Schema     :public
            Postgres target Table:vehicles_info_fact,vehicle_dim, seller_dim
            Audit Columns       :insert_date
