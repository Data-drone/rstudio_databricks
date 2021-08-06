FROM rocker/tidyverse:4.1.0

# update and deploy some dependencies
RUN apt-get update -y && \
    apt-get install -y libsasl2-dev libxml2-dev unixodbc-dev libsasl2-modules-gssapi-mit

# Load the Databricks ODBC Drivers
RUN wget -O /opt/SimbaSparkODBC-2.6.17.0024-Debian-64bit.zip https://databricks-bi-artifacts.s3.us-east-2.amazonaws.com/simbaspark-drivers/odbc/2.6.17/SimbaSparkODBC-2.6.17.0024-Debian-64bit.zip && \
    unzip /opt/SimbaSparkODBC-2.6.17.0024-Debian-64bit.zip -d /opt && \
    dpkg -i /opt/SimbaSparkODBC-2.6.17.0024-Debian-64bit/simbaspark_2.6.17.0024-2_amd64.deb

# file is in /opt/simba/spark/lib/64/\

# setup odbc inis
COPY odbc_dsn/odbc.ini /etc/odbc.ini
COPY odbc_dsn/odbcinst.ini /etc/odbcinst.ini

ENV ODBCINI=/etc
ENV ODBCSYSINI=/etc
# (Contains the configuration for debugging the Simba driver)
ENV SIMBASPARKINI=/opt/simba/spark/lib/64/simba.sparkodbc.ini 

USER rstudio

## Copy over R project
COPY --chown=rstudio Example_Code/test_connection.R /home/rstudio/test_connection.R
COPY --chown=rstudio Example_Code/install_libraries.R /home/rstudio/install_libraries.R

RUN r /home/rstudio/install_libraries.R

USER root

## Set env variables for Databricks connect
#### The following are just examples
ENV DBSQL_HOST=<adb-xxyyzzzzzzzz.azuredatabricks.net>
ENV DBSQL_USERTOKEN=<my_user_token>
ENV DBSQL_HTTPPATH=</sql/1.0/endpoints/example>

