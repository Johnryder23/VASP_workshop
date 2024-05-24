#!/bin/bash

##General
#SBATCH --job-name=C2H4_VASP_calc
#SBATCH --account=nesi99999
#SBATCH --time=00:30:00
#SBATCH --mem=10G
#SBATCH --output=job_%j.out

##Parallel options
#SBATCH --nodes=1
#SBATCH --ntasks=4              #start 4 MPI tasks
#SBATCH --cpus-per-task=2       #create 2 threads XXX
#SBATCH --hint=nomultithread

WORKDIR=../output
mkdir -p "$WORKDIR" && cd "$WORKDIR" || exit -1

module purge
module load VASP/6.3.2-intel-2022a
srun vasp_std

