#!/bin/bash

echo "dbt project folder set as \"${DBT_PROJECT_FOLDER}\""
cd ${DBT_PROJECT_FOLDER}

echo connection settings to snowflake

sed -i "s/_account_/${SNOWFLAKE_ACCOUNT}/g" profiles.yml
sed -i "s/_user_/${SNOWFLAKE_USER}/g" profiles.yml
sed -i "s/_password_/${SNOWFLAKE_PASSWORD}/g" profiles.yml
sed -i "s/_role_/${SNOWFLAKE_ROLE}/g" profiles.yml
sed -i "s/_db_/${SNOWFLAKE_DB}/g" profiles.yml
sed -i "s/_wh_/${SNOWFLAKE_WH}/g" profiles.yml
sed -i "s/_schema_/${SNOWFLAKE_SCHEMA}/g" profiles.yml
