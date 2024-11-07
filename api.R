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
