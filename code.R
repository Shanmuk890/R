library(plumber)
library(swagger)

#* Add two numbers
#* @param a The first number
#* @param b The second number
#* @get /add
function(a = 0, b = 0) {
  result <- as.numeric(a) + as.numeric(b)
  list(result = result)
}

#* Serve Swagger UI at /swagger
#* @plumber
function(pr) {
  pr %>%
    pr_set_api_spec("/swagger.json") %>%  # Swagger JSON
    pr_set_api_spec("/swagger")  # Swagger UI path
}

# If Swagger UI does not load automatically, serve it manually using 'swagger' package
swagger_ui <- function(req, res) {
  # We will serve Swagger UI on the '/swagger' route manually
  res$setHeader("Content-Type", "text/html")
  res$write(swagger::swagger_ui())  # This will serve Swagger UI
}

# Add Swagger UI to the Plumber API manually
pr <- plumber$new()
pr$handle("GET", "/swagger", swagger_ui)

# Start the API on port 8000
pr$run(host = "0.0.0.0", port = 8000)
