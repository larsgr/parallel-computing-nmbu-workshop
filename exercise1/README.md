# Exercise 1: Array jobs

The script `my_script.sh` contains a script that processes a file from the directory `$COURSES/Orion101-2022/parallel-computing/exercise1/data/`. This directory has many files and we want to improve the script so that it can processes all the files efficiently using `sbatch --array`

* Go to the Orion Wiki https://orion.nmbu.no/ and read the "Array jobs" sub-section on the "SLURM" page.
* Now use what you learned to turn the script into an array job script.
* To test the script try running it on the first 30 files, but limit the number of concurrent jobs to five at a time.