# Use an official R base image
FROM rocker/r-ver:4.2.2

# Install system dependencies for Plumber and other R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Plumber R package
RUN R -e "install.packages('plumber')"

# Copy the R script to the container
COPY code.R /usr/local/bin/code.R

# Expose port 8000 (Plumber's default port)
EXPOSE 8000

# Command to run the API using Plumber
CMD ["R", "-e", "pr <- plumb('/usr/local/bin/code.R'); pr$run(host='0.0.0.0', port=8000)"]
