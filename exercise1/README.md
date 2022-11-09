# Exercise 1: Array jobs

The script `my_script.sh` contains a script that processes a single file from the directory `$COURSES/Orion101-2022/parallel-computing/exercise1/data/`. This directory has many files and we want to improve the script so that it can processes all the files efficiently using `sbatch --array`

* Go to the Orion Wiki https://orion.nmbu.no/ and read the "Array jobs" sub-section on the "SLURM" page.
* Now use what you learned to turn the script into an array job script.
* To test the script try running it on the first 4 files, but limit the number of concurrent jobs to 2 at a time.
* Use `sacct` to look at the runnning/finished jobs. To display more useful info use `sacct --format JobID,JobName,Partition,AllocCPUS,ReqMem,MaxRSS,State,ExitCode,elapsed,userCPU,node`

Example of the output from sacct:

```plaintext
JobID           JobName  Partition  AllocCPUS     ReqMem     MaxRSS      State ExitCode    Elapsed    UserCPU        NodeList
------------ ---------- ---------- ---------- ---------- ---------- ---------- -------- ---------- ---------- ---------------
11512341_1   my_array_+   smallmem          2         1G             COMPLETED      0:0   00:00:11  00:00.006            cn-3
11512341_1.+      batch                     2                 1428K  COMPLETED      0:0   00:00:11  00:00.006            cn-3
11512341_2   my_array_+   smallmem          1         1G             COMPLETED      0:0   00:00:11  00:00.012            cn-8
11512341_2.+      batch                     1                 1264K  COMPLETED      0:0   00:00:11  00:00.012            cn-8
11512341_3   my_array_+   smallmem          2         1G             COMPLETED      0:0   00:00:10  00:00.009            cn-3
11512341_3.+      batch                     2                 1432K  COMPLETED      0:0   00:00:10  00:00.009            cn-3
11512341_4   my_array_+   smallmem          1         1G             COMPLETED      0:0   00:00:10  00:00.012            cn-6
11512341_4.+      batch                     1                 1260K  COMPLETED      0:0   00:00:10  00:00.012            cn-6
```
