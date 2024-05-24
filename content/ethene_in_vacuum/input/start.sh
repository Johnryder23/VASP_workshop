#!/bin/bash -e

cd ../output && cp ../input/* .

#clear environment (and hide warning message)
module purge 2> /dev/null
# load VASP. by not specifying a particular version, the newest version is loaded by defalt.
module load VASP

#run VASP interactively
srun --job-name=C2H4_VASP_calc --partition=milan --time=00:02:00 --mem=2300 --nodes=1 --ntasks=4 --qos=debug --cpus-per-task=1 --acctg-freq=1 --hint=nomultithread vasp_std

# remove input files from output directory
ls ../input | xargs rm

#if you have X11 forwarding setup, unhash the following 4 lines:
 module load Python 2> /dev/null
 ase gui OUTCAR &
 module purge 2> /dev/null

#report the final energy and timing/memory stats from VASP
echo "-------------------------------------------------------------------------------------"
echo -e "\e[34mFREE ENERGIE OF THE ION-ELECTRON SYSTEM (eV)\033[0m"
grep "energy(sigma->0)" OUTCAR | tail -1
echo "-------------------------------------------------------------------------------------"

#print job stats from VASP and Slurm
#grep "General timing and accounting informations for this job:" OUTCAR -A 9

echo "-------------------------------------------------------------------------------------"
echo -e "\e[34mRuntime efficiency recorded by Slurm:\033[0m"
for job in $(sacct -u $USER -X -S now-20days -E now --state=COMPLETED --format=JobID -P | tail -n 1); do nn_seff $job; done

