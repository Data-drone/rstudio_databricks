library(DBI)
library(tidyverse)
library(dplyr)

conn <- DBI::dbConnect(
  odbc::odbc(),
  dsn             = "Databricks-Spark",
  Host            = Sys.getenv("DBSQL_HOST"),
  Port            = 443,
  SparkServerType = 3,
  Schema          = "default",
  ThriftTransport = 2,
  SSL             = 1,
  AuthMech        = 3,
  UID             = "token",
  PWD             = Sys.getenv("DBSQL_USERTOKEN"),
  HTTPPath        = Sys.getenv("DBSQL_HTTPPATH")
)

# Use in_schema("schema", "database") for different database
# note this example is for the nyctaxidelta table which is 
# from the NYC taxi dataset which has been loaded and cleaned
# See: 
table <- tbl(conn, "nyctaxidelta") 

average_fare_for_many_passenger <- table %>%
  filter(passenger_count > 3) %>%
  group_by(neighborhood) %>%
  summarise(mean_fare = mean(fare_amount)) %>%
  collect()