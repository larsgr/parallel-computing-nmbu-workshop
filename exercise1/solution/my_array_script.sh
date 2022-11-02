#!/bin/bash

infile="$COURSES/Orion101-2022/parallel-computing/exercise1/data/file001"
outdir="$SCRATCH/Orion101-2022/parallel-computing/exercise1/output"

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