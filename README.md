# Parallel Computing - A workshop on how to spam the Orion compute cluster

> Orion is the High Performance Computing (HPC) at the Norwegian University of Life Sciences (NMBU)

This is a hands-on workshop introducing users of Orion to techniques to run their scripts in parallel.

Overview: 

* SLURM array jobs (hands task 1)
* Parallel vs Distributed - single node vs multiple nodes
* About software with built-in parallel functionality
* Parallel execution in bash scripts (task 2)
* Parallel execution in R (task 3)
* Efficiency - not everything can be run in parallel
* About workflow managers (snakemake/nextflow) and how they facilitate parallel execution

## Setting up for the workshop

It is recommended to clone this repo to somewhere on your home directory on Orion. This can be done in RStudio on Orion by creating a new project from git repo.

1. open the Orion Wiki https://orion.nmbu.no/ (you will use this later)
2. open Jupyterhub https://orion.nmbu.no/jupyter/ and launch Rstudio
3. In RStudio: File -> New project -> Version Control -> Git -> Paste repo URL

## Intro

### The problem we want to solve



