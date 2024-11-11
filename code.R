# Load the plumber package
library(plumber)

#' Add two numbers
#' @param x A number
#' @param y A number
#' @get /add
function(x = 0, y = 0) {
  result <- as.numeric(x) + as.numeric(y)
  return(list(result = result))
}
pr <- plumb("api.R")
pr$run(host = "0.0.0.0", port = 8000, swagger = TRUE)
