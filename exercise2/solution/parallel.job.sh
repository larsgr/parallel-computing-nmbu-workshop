#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=1G
#SBATCH --partition=COURSE-CPU
#SBATCH --constraint=avx2         # apparently the parallel command is compiled for newer CPUs
#SBATCH --job-name=my_parallel_job

module load parallel

# get the input directory as argument
indir=$1
outdir="$SCRATCH/Orion101-2022/parallel-computing/exercise2/output"

ls $indir | parallel -P $SLURM_NTASKS bash my_script2.sh $indir/{} $outdir

# Note: to submit the job for testing:
# sbatch --ntasks=2 solution/parallel.job.sh $SCRATCH/Orion101-2022/parallel-computing/exercise1/output
