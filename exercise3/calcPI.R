
# silly way of estimating PI
estimatePI <- function(N){
  x = runif(n=N) # random number between 0 and 1 
  y = runif(n=N) 
  d = sqrt(x^2 + y^2)
  4*mean(d<1) # 4 x proportion of points inside quarter-circle
}


system.time({
  my_pi <- mean(replicate(100,estimatePI(1e7)))
})
# Note this takes 1~2 minutes to run..

cat("PI ~",my_pi,"\n")
