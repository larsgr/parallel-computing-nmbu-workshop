# Parallel Computing - A tutorial on how to spam the Orion compute cluster

> Orion is the High Performance Computing (HPC) at the Norwegian University of Life Sciences (NMBU)

This is a hands-on tutorial that introducing users of Orion to some techniques to run their scripts in parallel.

Overview: 

* SLURM array jobs (exercise 1)
* About software with built-in parallel functionality
* (not sure) Parallel vs Distributed - single node vs multiple nodes. Multi-threading
* Parallel execution in bash scripts (exercise 2)
* Parallel execution in R (exercise 3)
* About workflow managers (snakemake/nextflow) and how they facilitate parallel execution

## Setting up for the workshop

It is recommended to clone this repo to somewhere in your home directory on Orion. This can be done in RStudio on Orion by creating a new project from git repo:

0. (connect to VPN if you are using mac)
1. open the Orion Wiki https://orion.nmbu.no/ (you will use this later)
2. open Jupyterhub (there is a  link in the Orion Wiki) and launch Rstudio (whatever version)
3. In RStudio: File -> New project -> Version Control -> Git -> Paste repo URL (at github click the green Code button which will give you the URL. Use the HTTPS URL)

## Intro

### The problem

The computer is taking too long to process the data!

Most programs run in serial, i.e. it is running one instruction at a time on a single core. So even if you run it on a compute cluster with thousands of cores it will not finish any faster (see Figure 1). To speed things up we need to run the program in parallel across multiple cores. 

>![Image illustrating poor multi-core utilization](https://i.redd.it/9tu18n684z331.jpg)
>
>**Figure 1: poorly utilized cores**


### Some vocabulary

* **CPU** - Central Processing Unit a.k.a. the processor. Can refer to the physical chip which contain multiple **cores**, but is also used to refer to a single core.
* **core** - A single processing unit within a CPU. Can run a single program (thread) at a time.
* **process** - An instance of a active program. Typically has a single thread.
* **thread** - A process can seperate its execution into multiple threads that can run in parallel on multiple cores. Threads have shared memory which makes communication between threads easy.

* **Hyper-threading:tm:** - An intel technology that makes it look like the CPU has twice as many cores.


## Array jobs

If you need to perform the same task multiple times but with different data and the order of execution is irrelevant, then you can submit an **Array job** on SLURM using `sbatch --array=indexes`.

When submitting an array job, SLURM will execute your script as many times the number of `indexes` you provide (`indexes` being a set of numbers that identify each individual job). The individual jobs will be distributed across the cluster, i.e. they may end up running on different nodes.

It is possible to limit the number of jobs running at the same time. This is important if you have a large array with thousands of jobs, as it would otherwise allocate all the cores on the cluster (which is a nuisance for the other users). 

### Exercise 1

> Exercise 1: Go to the [exercise1](exercise1/) directory

## About software with built-in parallel functionality 

Most respectable bioinformatic tools have the ability to run in parallel. You can check their help to see if there is an option to run in parallel. Different tools use different names for their option, e.g:

```bash
samtools sort --threads
pigz --processes
Trinity --CPU
```

Although they use different terms is usually means the same.

### Multi-threading vs multiple processes

There are two different ways for a program to run in parallel, either it can start more processes or it can start more threads within the process. You can see this if you inspect the running processes with `top` as it will by default show one entry per process, multi-threaded applications can show more than 100% CPU usage. Threads are typically more efficient as they are faster to spawn and share the same resources as the parent process. 

### Efficiency of parallel software may vary

Some algorithms/tasks are more difficult parallelize than other. Even though software has the option to run in parallel it doesn't mean that it runs in parallel the whole time. Typically there will be some parts that don't run in parallel and there will be diminishing returns on increasing the number of cores to use. 

### Memory/cpu balance

Be aware of the memory usage when running many jobs concurrently as the nodes might run out of memory before running out of available cores. When you run a program in parallel in separate processes like in an array job, each task will require memory, software that uses multi-threading can share memory and therefore use less total.



## Parallel execution in bash scripts

In some cases you may want to start multiple process to run in parallel from a bash script. There are several ways to achieve this:

### The & operator and wait command

The `&` operator is used to run a command in the background. As opposed to normal execution, where the script will wait until each command is finished before continuing, the scipt will continue and allow you to run more processes in parallel.

For example if you want to zip two files in background:

```bash
gzip bigfile1 & gzip bigfile2 &
```

This can be used in a loop. Here is an example that executes a command on all the files in a folder:

```bash
indir="/path/to/some/files"
for filename in $indir/*
do
    somecommand $filename &
done

# wait for all the background processes to finish
wait

echo All done!
```

The `wait` comand is used to wait for all sub-processes that are running in the background.

### parallel

The `parallel` command, as the name implies, is used to run commands in parallel.

> Note: `parallel` is not installed by default but is available as a module on Orion (`module load parallel`). 

Example that runs some command for each file in a directory with at most two in parallel:
```bash
module load parallel

indir="/path/to/some/files"
ls $indir | parallel -P 2 someCommand $indir/{}
```

* The `-P 2` argument defines how many processes to run in parallel 
* The `{}` is replaced with one line from the `stdin`, which in this case is a filename from the `ls $indir`

### xargs -P

The `xargs` command is used to execute a command several times with arguments taken from `stdin` or a file. It would normally do it in series but with the `-P` option you can specify how many you would like to run in parallel.

```bash
indir="/path/to/some/files"
ls $indir | xargs -d "\n" -P 2 -i someCommand {}
```

* The `-d "\n"` argument tells it to use newline (`\n`) as delimiter, i.e. read one line at a time. Otherwise it would split on spaces as well.
* The `-i` option tells it to use `{}` as the replacement indicator allowing more flexibility in forming the command arguments, otherwise it would have just been added as the last argument of the command

`xargs` is a perhaps a bit more complicated to use than `parallel` but has the advantage that it comes preinstalled with linux.

### Exercise 2

> Exercise 2: Go to the [exercise2](exercise2/) directory



## Parallel execution in R

If you do a lot of heavy computation in R then it can be helpful to speed it up by running it in parallel on the Orion cluster. Here we will look at a few ways of achieving this.

### mclapply

`mclapply()` is the "multi-core" version of `lapply()`. If you are familiar with `lapply()` then this is probably the easiest way to execute in parallel. You just need to specify the number of cores to use with the parameter `mc.cores`.

The following example runs the function `myfunction()` 100 times using 4 cores (i.e. 25 times each):
```
library(parallel)

results <- mclapply(1:100, myfunction, mc.cores = 4)
```

Under the hood `mclapply()` uses "fork" to make duplicates of the parent process. This has the advantage that all the loaded data and libraries are available to the called function.

> Note: Because it uses "fork", `mclapply` does not work on windows. If you try it would just work like a normal `lapply`


### Socket cluster with parLapply

Another function in the `parallel` library is parLapply....

```r
library(parallel)

cl <- makeCluster(4)

results <- parLapply(cl,1:10,myfunction)

stopCluster(cl)
```

* makeCluster() starts new processes that wait for commands.
* stopCluster() to stop these processes

The slave/child processes do not inherit the data/libraries loaded so it has to be done explicitly

* clusterExport() Copy data to all child processes
* clusterEvalQ() Evaluate expression on each child process. E.g. load libraries.




It comes with the `parallel` library that comes pre-installed with R. 
### Running R on the cluster

You have to load the R module. If you usually use Rstudio then make sure to use the same version so that the same packages are available.

## Using workflow managers (e.g. nextflow/snakemake)
