#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=1G
#SBATCH --partition=COURSE-CPU
#SBATCH --job-name=calcPI


module load R/4.0.4

Rscript calcPI_foreach.R
