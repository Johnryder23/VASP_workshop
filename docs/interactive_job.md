## General
This calculation is a standard ionic and electronic energy minimisation for ethane in vacuum. Because the calculation is short, it can be run interactively from the command line. A Bash script will be used to set up and submit the calculation.


To start an interactive Slurm job, we will execute `srun` directly - and not from *within* a batch script sumitted with `sbatch`. Subbmitting with `srun` instead of `sbatch` makes the job execute in real time, or, in other words, reads `stdin` from the terminal and prints 'stdout' and 'stderr' to the terminal. 

!!! warning
    running a job in this way means if your connection with NeSI drops, the job will fail - as 'stdin' is broken. Therefore, running jobs interactively is only appropriate for short calculations or quick checks.


## Input parameters

Lets start by inspecting the `./input/INCAR` file.

We set the desired exchange-correlation functional with the `GGA` tag. Keep in mind the GGA type should match that of the `POTCAR` pseudopotential. If these do not match, VASP will give a `warning`.


***DISCUSS parallelisation options used in this calc NPAR HERE***

I happen to know that this calculation has 12 bands (i.e., `NBANDS`= 12) ...describe how we find NBANDS before running full calc here... Knowing this, lets keep it simple and submit our calculation with 12 cores, such that each band (or KS orbitals) gets its own core.

We do this by setting `NPAR = 12` in the `INCAR`.


## Start the calculation
Inspect and then execute the script `start.sh` (by typing `./input/start.sh`). You may also wish to inspect the other files in the `input` directory.



## Approximate runtime statistics
--------------------------
total cpu time (approx): XX:XX:XX
--------------------------
memory used:
`XXX`
--------------------------
MPI tasks:
`XXX`
--------------------------
CPU efficiency:
`XXX`
--------------------------
OpenMP threads:
`XXX`
--------------------------


