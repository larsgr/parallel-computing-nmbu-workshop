# Exercise 2: parallel execution in bash scripts

Since the script in exercise 1 took only 10 seconds to process each file it is a bit overkill to create a separate job for each file. The new strategy is to create a single SLURM job that allocates a certain amount of cores using the `--ntasks` argument. The slurm script can then processes all the files using the allocated cores.

> The value from the `--ntasks` argument is available in the slurm job as the `$SLURM_NTASKS` environment variable.

The script `my_script2.sh` has been slightly modified so that it can executed as a separate script with argumnts for the input file (`$infile`) and output directory (`$outdir`). To execute the script you can use:
```bash
bash my_script2.sh INPUT_FILE OUTPUT_DIR
```

1. Create a slurm job script that executes `my_script2.sh` for each file in a given directory in parallel using `$SLURM_NTASKS` cores. Use any of the methods mentioned in the tutorial.
2. Try submitting the slurm job with 2 cores. For testing it is a good idea to use the output directory from exercise 1 as this should only have 4 files. Use `$SCRATCH/Orion101-2022/parallel-computing/exercise2/output` as output directory.
3. Check the job status with `sacct`. If it has failed check the log file. If it succeded check that the output was generated and did it take as long you expected? 

> NOTE: If you get an `Illegal instruction` error, add `--constraint=avx2` to the sbatch options

