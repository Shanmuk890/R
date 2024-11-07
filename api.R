library(plumber)

#* Return a greeting message
#* @get /hello
function() {
  list(message = "Hello, world!")
}

#* Add two numbers
#* @get /add
#* @param a The first number
#* @param b The second number
function(a = 1, b = 2) {
  sum <- as.numeric(a) + as.numeric(b)
  list(result = sum)
}

# Ensure the Plumber API listens on the right port (Cloud Run uses 8080 by default)
pr <- plumb('api.R')
port <- as.integer(Sys.getenv('PORT', 8080))
pr$run(host = '0.0.0.0', port = port)
