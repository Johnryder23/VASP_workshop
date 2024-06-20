##GPU calculation

I have scrambled the POSCAR a bit here to approximate a real system. The POSCAR defines a system of 432 Fe atoms in a non-perfect lattice! that is a lot of work for VASP...

So lets start this job with 2 NVDIA Tesla P100 GPUs.



Lets go onto the node and monitor the GPUs in real time with the `nvidia-smi` command line utility.

???+ question "why is the PID from `nvidia-smi` different to that printed in output file?"
    
    notice that the PIDs listed by 'nvidia-smi' are different than those listed at the top of the job_*.out file. Why is this? Recall we started VASP with the following `srun` command:
    ```
    srun bash -c 'echo -e "\nI am MPI task #${SLURM_PROCID}. Since there are ${OMP_NUM_THREADS} OpenMP threads, I will be assigned the following ${OMP_NUM_THREADS} physical cores on $(hostname):\n$(taskset -apc $$)\nRecall, MPI VASP distributes work and data over the MPI ranks on a per-orbital basis (in a round-robin fashion). MPI+OpenMP VASP, however, distributes the work of each Bloch orbital over the ${OMP_NUM_THREADS} OpenMP threads, and not between MPI tasks." && vasp_std' 
    ```
    where `taskset -apc $$` returned the process ID of the current shell instance. If we go onto the compute node for this job and run `pstree -p <PID_from_job_*.out>` we will see that `vasp_std` (the one running on the GPU) is a child process of the Slurm script shell PID.


!!! question
    I am a question





How much faster is this with a GPU than it is on CPUs?

Lets adjust our submit script slightly to run this without a GPU.
