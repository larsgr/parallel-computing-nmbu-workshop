# generate some pretend data files
outpath="/mnt/courses/Orion101-2022/parallel-computing/exercise1/data"
N = 100
data=c(rep("data",8),"BATMAN")
for(i in 1:N){
  write(x = data,file = file.path(outpath,sprintf("file%03i",i)))
}
