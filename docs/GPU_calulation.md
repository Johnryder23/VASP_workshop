##GPU calculation

You must use a single MPI rank per GPU. We can make sure the number of GPUs is tied to the number of tasks by using `--gpus-per-task` instead of `--gpus-per-node`. Note, on NeSI we can only request a max of 4 GPUs at a time, and consequently, are limited to a max of 4 MPI tasks. Running a VASP job with a max of 4 tasks seems like it would be terribly slow, however, this is not the case because of the following:

- When running VASP on GPUs, much less is asked of the CPUs. There are still parts of the code that run CPU-side, but (dependent on the calculation), the GPU(s) now do the heavy lifting.

- Our GPU versions of VASP support OpenMP multi-threading (I will call these versions MPI+OpenMP VASP, hence the 'hybrid' parallelisation. OpenMP multi-threading is not the same thing as hyperthreading! Please leave `--hint=nomultithread` on).

Lets expand on the second bullet point above.

MPI VASP usually distributes work and data over available MPI ranks on a per-orbital basis (in a round-robin fashion, i.e., Bloch orbital 1 resides on task 1, orbital 2 on task 2. and so on). Since we have so few MPI tasks, we *might* need to leverage more of the available CPU power, which is where OpenMP threads come in. OpenMP adds a second layer of parallelisation, such that it allows us to distribute a single Bloch orbital over multiple OpenMP threads. These OpenMP threads reside 'within' their parent MPI task.

Say we have 2 GPUs and therefore 2 MPI tasks, and 12 OpenMP threads per task. Each OpenMP thread will get its own core, giving us 24 cores. Our Bloch orbitals are assigned to these 24 cores in the same round-robin fashion. You may notice OpenMP effectively does what `NCORE` did in older versions of VASP. Going forward, OpenMP will be used in place of the `NCORE` function.

!!! 




Here we have a large supercell, consisting of 232 Si atoms in a Cubic lattice (`POSCAR` obtained from [mp-1201492](https://next-gen.materialsproject.org/materials/mp-1201492/#crystal_structure)). That makes a total of 581 KS orbitals!

If we were to perform a typical electronic minimization on this structure using the following `INCAR`:
```
#Electronic relaxation
 ENCUT = 300              #specifies the cutoff energy in eV for the planewave basis set
 EDIFF = 1E-4             #electronic break condition

#Ionic relaxation
 EDIFFG = -0.001          #ionic relaxation break condition. If negative, the relaxation is stopped when the norms of all the forces are smaller than |EDIFFG|.
 IBRION = 1               #determines how the ions are updated and moved
 ISYM = 0                 #symmetry treatment

#Method
 GGA = PE                 #specifies the exchange-coorelation functional used
```
And the following compute resources:
```
#SBATCH --nodes=1
#SBATCH --partition=milan
#SBATCH --ntasks=128
#SBATCH --mem=50G
#SBATCH --hint=nomultithread

```
i.e., an entire node on the Milan partition - this calculation takes 01:14:40 to finish.

!!! note
    In this calculation only a single ionic step is performed as norms of all the forces between atoms are less than 0.001 eV.


We can easily see that if this `POSCAR` was more dissorded and a few dozen ionic steps were required, this calculation would easily take more than a day to complete.


Now try this same example on a single P100 GPU. A few changes are required in the `INCAR`:
```
#Electronic relaxation
 ENCUT = 300              #specifies the cutoff energy in eV for the planewave basis set
 EDIFF = 1E-4             #electronic break condition

#Ionic relaxation
 EDIFFG = -0.001          #ionic relaxation break condition. If negative, the relaxation is stopped when the norms of all the forces are smaller than |EDIFFG|.
 IBRION = 1               #determines how the ions are updated and moved
 ISYM = 0                 #symmetry treatment

#Method
 GGA = PE                 #specifies the exchange-coorelation functional used

#Parallelization
#NCORE =            #determines the number of compute cores that work on an individual orbital
KPAR = 2            #determines the number of k-points that are to be treated in parallel
NSIM = 10           #sets the number of bands that are optimized simultaneously by the RMM-DIIS algorithm (ALGO=Normal)

```
Do not set `NCORE` for a VASP GPU job. Anything different from `NCORE=1` will significantly slow down a GPU run. This setting is outdate anyway,  OpenMP 



Also, our Slurm submission script must be adapted:
```
<print slurm script here>
```
text text text discuss batch script changes





 

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
