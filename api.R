# api.R
library(plumber)

# Example route for testing
#* @get /hello
#* @serializer json
function() {
  return(list(message = "Hello, World!"))
}

# Initialize and run the Plumber API
pr <- plumb("api.R")

# Use the port set by Cloud Run (or fallback to 8080)
pr$run(host = '0.0.0.0', port = as.integer(Sys.getenv('PORT', 8080)))
