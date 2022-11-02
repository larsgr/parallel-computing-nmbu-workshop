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

# alternative 1:
#
# Prepare a list of files select from a line in the list, e.g:
# ls $COURSES/Orion101-2022/parallel-computing/exercise1/data > filelist.txt
#
# Then use awk to read line number $SLURM_ARRAY_TASK_ID from the list:
infile=$indir/$(awk ' NR=='$SLURM_ARRAY_TASK_ID'' filelist.txt)


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