# Use an official R image from Docker Hub
FROM rocker/r-ver:4.2.3

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install system dependencies and R packages required for Plumber and Swagger UI
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages('plumber')"

# Copy your R script (code.R) into the container
COPY your_api_file.R /usr/src/app/

# Expose the port on which the Plumber API will run
EXPOSE 8000

# Run the R script to start the Plumber API with Swagger UI enabled
CMD R -e "library(plumber); pr <- plumb('/usr/src/app/code.R'); pr %>% swagger(); pr$run(host='0.0.0.0', port=8000)"
