#!/bin/bash -e

##General
#SBATCH --job-name=vasp_gpu_calc
#SBATCH --account=nesi99999
#SBATCH --time=24:00:00
#SBATCH --output=../output/vasp_job_%j/job_%j.out

##Parallel options
#SBATCH --nodes=1
#SBATCH --partition=milan
#SBATCH --ntasks=128
#SBATCH --mem=120G
#SBATCH --hint=nomultithread

# Copy all files in current directory to the working directory
cp $(find . -maxdepth 1 -type f) ../output/vasp_job_${SLURM_JOB_ID}
cd ../output/vasp_job_${SLURM_JOB_ID}

module purge 2> /dev/null
module load VASP/6.3.2-intel-2022a
srun vasp_std

