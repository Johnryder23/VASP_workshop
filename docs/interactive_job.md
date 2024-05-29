## General
This calculation is a standard ionic and electronic energy minimisation for ethane in vacuum. Because the calculation is short, it can be run interactively from the command line. A Bash script will be used to set up and submit the calculation.


To start an interactive Slurm job, we will execute `srun` directly - and not from *within* a batch script sumitted with `sbatch`. Subbmitting with `srun` instead of `sbatch` makes the job execute in real time, or, in other words, reads `stdin` from the terminal and prints 'stdout' and 'stderr' to the terminal. 

!!! warning
    running a job in this way means if your connection with NeSI drops, the job will fail - as 'stdin'is diretly from the terminal. Therefore running jobs interactively is only appropriate for short calculations.


## Input parameters
VASP generally requires four input files:
1. INCAR
Configuration file for VASP. Tells VASP what type of calculation you want to perform, and the parameters of the calculation.
2. KPOINTS
File specifying the **k** points density. These **k** points are the sampling points of the density in the Brillouin zone. More **k** points is required for systems with large fluctuations in electron density.
3. POTCAR
File containing the pseudopotential(s) for all atom(s).
4. POSCAR
The `POTCAR` specifies the atomic coordinates the calculations starts with.

Lets start by inspecting the `./input/INCAR` file.

We start by specifying a name for the calculation. This is only user by VASP and not important.
The settings under `electronic` and `ionic relaxation` are defined in the file.

By setting `IBRION = 2`, the ions are updated and moved according to the conjugate gradient algorithm.

The conjugate gradient algorithm determines the movement of ions via the following steps:
```
1. make a steepest descent step starting from one ionic position:
    1. set the search direction equal to the direction of the largest gradient
    2. do line minimization until forces along the search direction for this ion become small
    3. update ionic position
2. make a conjugate gradient step starting from the updated position of the same ion:
    1. find the direction of the largest gradient
    2. set the search direction equal to the direction of the conjugate gradient, that is obtained by orthogonalizing the largest gradient w.r.t. the search direction of the steepest descent step
    3. do line minimization until forces along the search direction for this ion become small
    4. update ionic position
3. repeat 1.-2. until gradient becomes small or the maximum number of ionic steps is reached
```

We set the desired exchange-correlation functional with the `GGA` tag. Keep in mind the GGA type should match that of the `POTCAR` pseudopotential. If these do not match, VASP will give a warning.

Recall that the pseudopotentials in the `POTCAR` file must be sorted according to the order of atoms in the `POSCAR`. ***MENTION ASE UTILITY TO DO THIS HERE***


***DISCUSS  NPAR HERE***

## Start the calculation
Inspect and then execute the script `start.sh` (by typing `./input/start.sh`). You may also wish to inspect the other files in the `input` directory.



I happen to know that this calculation has 12 bands (i.e., `NBANDS`= 12) ...describe how we find NBANDS before running full calc here... Knowing this, lets keep it simple and submit our calculation with 12 cores, such that each band (or KS orbitals) gets its own core.

We do this by setting `NPAR = 12` in the `INCAR`.




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


