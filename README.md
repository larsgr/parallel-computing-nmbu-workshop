# Parallel Computing - A workshop on how to spam the Orion compute cluster

> Orion is the High Performance Computing (HPC) at the Norwegian University of Life Sciences (NMBU)

This is a hands-on workshop introducing users of Orion to some techniques to run their scripts in parallel.

Overview: 

* SLURM array jobs (task 1)
* Parallel vs Distributed - single node vs multiple nodes
* About software with built-in parallel functionality
* Parallel execution in bash scripts (task 2)
* Parallel execution in R (task 3)
* Efficiency - not everything can be run in parallel
* About workflow managers (snakemake/nextflow) and how they facilitate parallel execution

## Setting up for the workshop

It is recommended to clone this repo to somewhere on your home directory on Orion. This can be done in RStudio on Orion by creating a new project from git repo.

1. open the Orion Wiki https://orion.nmbu.no/ (you will use this later)
2. open Jupyterhub and launch Rstudio (whatever version)
3. In RStudio: File -> New project -> Version Control -> Git -> Paste repo URL (at github click the gree Code button which will give you the URL. Use the HTTPS URL)

## Intro

### The problem

The computer is taking too long to process the data!

Most programs run in serial, i.e. it is running one instruction at a time. So even if you run it on a compute cluster with thousands of cores it will not finish any faster. To speed things up we need to run the program in parallel across multiple cores.

### Some vocabulary

* **CPU** - Central Processing Unit a.k.a. the processor. Typically refers to the physical chip which contain multiple **cores**, but it sometimes used to refer to a single core (e.g. "CPU hours" should be called "core hours").
* **core** - A single execution core within a CPU. Can run a single program (thread) at a time.
* **process** - An instance of a active program. Typically has a single thread.
* **thread** - A process can seperate its execution into multiple threads that can run in parallel on multiple cores. Threads have shared memory which makes communication between threads easy.

* **Hyper-threading:tm:** - An intel technology that makes it look like the CPU has twice as many cores.


## Part 1: Array jobs

If you need to perform the same task multiple times but with different data and the order of execution is irrelevant, then you can submit an **Array job** on SLURM using `sbatch --array=indexes`.

When submitting an array job, SLURM will execute your script as many times the number of `indexes` you provide (`indexes` being a set of numbers that identify each individual job). The individual jobs will be distributed across the cluster, i.e. they may end up running on different nodes.

> Exercise 1: see the [exercise1](exercise1/) directory

