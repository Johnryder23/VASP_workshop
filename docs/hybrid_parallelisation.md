See [Combining MPI and OpenMP](https://www.vasp.at/wiki/index.php/Combining_MPI_and_OpenMP) for this section

???+ note "Parallelisation terminology"
    The power of HPC comes from its scalability. Scientific programmes on a HPC need to make use of some form of parallelisation to exploit this scalability. Parallelisation methods are broadly broken into two catagories - [shared memory parallelisation](https://nesi.github.io/hpc-intro/064-parallel/index.html#shared-memory-smp) and [distributed memory parallelisation](https://nesi.github.io/hpc-intro/064-parallel/index.html#distributed-memory-mpi). As the names imply, shared memory parallelisation requires shared RAM between CPUs, where distributed memory parallelisation can run across CPUs that do not share RAM. This means shared memory parallelisation *must use CPUs on the same node*, whereas distributed memory parallelisation *can use CPUs on any number of nodes*. [OpenMP (Open Multi-Processing)](https://www.openmp.org/) and [MPI (Message Passing Interface)](https://docs.nesi.org.nz/Scientific_Computing/HPC_Software_Environment/Compiling_software_on_Mahuika/#compilers-and-toolchains) are common implimentations of shared memory parallelisation and distributed memory parallelisation respectively. 


## Why would we want to use MPI + OpenMP parallelisation?
On NeSI, VASP is available with OpenMP for all versions at or above VASP6.x.x.

The addition of OpenMP parallelisation is fairly new to VASP. What was wrong with just using MPI? Why do we need OpenMP 


## How to use MPI + OpenMP parallelisation
