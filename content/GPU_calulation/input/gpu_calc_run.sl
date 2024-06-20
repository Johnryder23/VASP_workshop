#!/bin/bash -e

##General
#SBATCH --partition=gpu
#SBATCH --gpus-per-task=P100:1            # You can change the 'type' GPU, but do not change the number of gpus-per-task.
#SBATCH --job-name=vasp_gpu_calc
#SBATCH --account=nesi99999
#SBATCH --time=00:01:00
#SBATCH --output=../output/vasp_job_%j/job_%j.out

##Parallel options
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=8                 # We reconmend testing this value. Set NELM=5 and NSW=3 (or something small) and check how long calculation takes to finish. Can also check CPU efficiency after the job has finished with nn_seff <job_id>  
#SBATCH --mem=30G
#SBATCH --hint=nomultithread



# Check that --ntasks is the same as the number of GPUs, if not exit with error
if [ "${SLURM_NTASKS}" -ne "${SLURM_GPUS_ON_NODE}" ]; then
  echo "Error: Number of MPI tasks (${SLURM_NTASKS}) is not equal to the nuumber of GPUs on the node (${SLURM_GPUS_ON_NODE}). Exiting."
  exit 1
fi

# Copy all files in current directory the working directory, as to not clutter current directory
cp $(find . -maxdepth 1 -type f) ../output/vasp_job_${SLURM_JOB_ID}
cd ../output/vasp_job_${SLURM_JOB_ID}

# Print long name of GPUs used for this job
echo -e "The following GPUs are allocated to this job:\n$(nvidia-smi -L)\n"

module purge 2> /dev/null
module load VASP/6.3.2-NVHPC-22.3-GCC-11.3.0-CUDA-11.6.2
srun --label bash -c 'echo -e "\nI am MPI task #${SLURM_PROCID}. Since there are ${OMP_NUM_THREADS} OpenMP threads, I will be assigned the following ${OMP_NUM_THREADS} physical cores on $(hostname):\n$(taskset -apc $$)\nRecall, MPI VASP distributes work and data over the MPI ranks on a per-orbital basis (in a round-robin fashion). MPI+OpenMP VASP, however, distributes the work of each Bloch orbital over the ${OMP_NUM_THREADS} OpenMP threads, and not between MPI tasks." && vasp_std'


