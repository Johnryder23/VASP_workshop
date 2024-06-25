##GPU calculation

Here a large supercell, consisting of 232 Si atoms in a Cubic lattice (`POSCAR` obtained from [mp-1201492](https://next-gen.materialsproject.org/materials/mp-1201492/#crystal_structure)). That is a total of 581 KS orbitals!

First perform a typical electronic minimization on this structure using the following `INCAR`:
```
<print INCAR here>

```
Notice





Lets take note of the `INCAR` settings:

<print INCAR here>




Notice a few k









 

"Theoretically, the GPU calculations will run faster the higher the value of NSIM you set, with the drawback being that the memory consumption on the GPUs increase with higher NSIM as well. The recommendation from the developers is that you should increase NSIM as much you can until you run out of memory. This can require some experimentation, where you have to launch your VASP job and the follow the memory use with the nvidia-smi -l command. I generally had to stop at NSIM values of 16-32."
From `Running VASP on Nvidia GPUs`

!!! note
    the message `Warning: ieee_invalid is signaling` may appear in your stdout file. This is only a warning, and can safely ignored. We can mute this warning, however, by setting `export NO_STOP_MESSAGE=1` in our submit script.

There is still some work that needs to be done on the GPU. now all 

So lets start this job with 2 NVDIA Tesla P100 GPUs.

notice in the INCAR we set EDIFFG = EDIFF = 0. so we will perform 10 electronic SCF loops and 5 ionic steps.

Lets go onto the node and monitor the GPUs in real time with the `nvidia-smi` command line utility.

???+ question "why is the PID from `nvidia-smi` different to that printed in output file?"
    
    notice that the PIDs listed by 'nvidia-smi' are different than those listed at the top of the job_*.out file. Why is this? Recall we started VASP with the following `srun` command:
    ```
    srun bash -c 'echo -e "\nI am MPI task #${SLURM_PROCID}. Since there are ${OMP_NUM_THREADS} OpenMP threads, I will be assigned the following ${OMP_NUM_THREADS} physical cores on $(hostname):\n$(taskset -apc $$)\nRecall, MPI VASP distributes work and data over the MPI ranks on a per-orbital basis (in a round-robin fashion). MPI+OpenMP VASP, however, distributes the work of each Bloch orbital over the ${OMP_NUM_THREADS} OpenMP threads, and not between MPI tasks." && vasp_std' 
    ```
    where `taskset -apc $$` returned the process ID of the current shell instance. If we go onto the compute node for this job and run `pstree -p <PID_from_job_*.out>` we will see that `vasp_std` (the one running on the GPU) is a child process of the Slurm script shell PID.



How much faster is this with a GPU than it is on CPUs?

Lets adjust our submit script slightly to run this without a GPU.
