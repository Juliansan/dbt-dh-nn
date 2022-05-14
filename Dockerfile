FROM python:3.8.5

# Update and install system packages
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  git libpq-dev python-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install DBT
RUN pip install -U pip

#Install dependencies from requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt


# Set environment variables
ENV DBT_DIR /dbt_project
ENV DBT_PROFILES_DIR=/dbt_project
ENV PATH "${PATH}:${DBT_DIR}"

# Set working directory
WORKDIR $DBT_DIR


# Run dbt
CMD ["bash"]