library(foreach)
library(doParallel)

# silly way of estimating PI
estimatePI <- function(N){
  x = runif(n=N) # random number between 0 and 1 
  y = runif(n=N) 
  d = sqrt(x^2 + y^2)
  4*mean(d<1) # 4 x proportion of points inside circle
}


numCores = as.integer(Sys.getenv("SLURM_NTASKS",unset = 1))

registerDoParallel(numCores)
cat("Using",numCores,"cores\n")

system.time({
  my_pi <- foreach( i = 1:100, .combine=mean) %dopar% {estimatePI(1e7)}
})

cat("PI ~",my_pi,"\n")
