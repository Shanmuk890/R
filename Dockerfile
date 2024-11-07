# Use the rocker/r-ver image, which includes a basic R environment
FROM rocker/r-ver:4.2.2

# Install system dependencies required for Plumber and R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install the 'plumber' package from CRAN
RUN R -e "install.packages('plumber')"

# Set the working directory inside the container
WORKDIR /usr/local/src/app

# Copy the Plumber API script into the container
COPY api.R /usr/local/src/app/

# Expose the port that Plumber will listen on
EXPOSE 8000

# Run the Plumber API
CMD ["R", "-e", "pr <- plumber::plumb('api.R'); pr$run(host='0.0.0.0', port=8000)"]
