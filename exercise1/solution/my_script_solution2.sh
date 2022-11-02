#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem=1G
#SBATCH --partition=smallmem
#SBATCH --job-name=my_array_script
#SBATCH --output=arrayTestOutput-%j-%a.out

indir="$COURSES/Orion101-2022/parallel-computing/exercise1/data"
outdir="$SCRATCH/Orion101-2022/parallel-computing/exercise1/output"

echo This is array job number $SLURM_ARRAY_TASK_ID

# There are multiple ways to figure out the input file for this array task

# alternative 2
#
# Noticing that all the file names are numbered with the specific format "fileNNN" we can use
# $SLURM_ARRAY_TASK_ID directly to generate the file name.
# Using "printf" to add leading 0's
infile=$indir/$(printf "file%0.3d" $SLURM_ARRAY_TASK_ID)



#### original script continues here ####

# create output directory (-p makes parent directories if needed and gives no errors if it exists)
mkdir -p $outdir

# output file to have same name as infile
outfile="$outdir/$(basename $infile)"

echo "Processing file: $infile"
# pretend to be working for 10 seconds:
sleep 10
# just copy the data to make it look like we have done something:
cat $infile > $outfile 

echo "Done. Output written to $outfile"