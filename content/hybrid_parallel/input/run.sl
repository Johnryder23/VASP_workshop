#!/bin/bash -e

##General
#SBATCH --job-name=hybrid_parallel_job
#SBATCH --account=nesi99999
#SBATCH --time=01:30:00
#SBATCH --output=./vasp_job_%j/%j.out

##Parallel options
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --hint=nomultithread
#SBATCH --chdir=./vasp_job_%j/

##If running on GPU partition (intel nodes) then export the following variable 
#export MKL_THREADING_LAYER=INTEL

cp * ./vasp_job_${SLURM_JOB_ID}/
#cd vasp_job_${SLURM_JOB_ID}

export OMP_NUM_THREADS=4

module purge
module load VASP/6.3.2-NVHPC-22.3-GCC-11.3.0-CUDA-11.6.2
srun vasp_std
