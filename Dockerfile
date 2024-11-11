# Use a base image
FROM rocker/r-ver:4.2.2

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev && \
    rm -rf /var/lib/apt/lists/*

# Install the Plumber package
RUN R -e "install.packages('plumber')"

# Set the working directory
WORKDIR /usr/local/src/app

# Copy the api.R file into the container
COPY api.R /usr/local/src/app/

# Expose the port that the Plumber API will listen to
EXPOSE 8080

# Command to run the API (for example)
CMD ["R", "-e", "plumber::pr_run('api.R', host = '0.0.0.0', port = 8080)"]
