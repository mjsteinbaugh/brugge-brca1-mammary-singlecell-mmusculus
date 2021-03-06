#!/bin/bash

# SLURM
# https://slurm.schedmd.com/sbatch.html

#SBATCH --job-name=aggr                # Job name
#SBATCH --partition=medium             # Partition name
#SBATCH --time=3-00:00                 # Runtime in D-HH:MM format
#SBATCH --nodes=1                      # Number of nodes (keep at 1)
#SBATCH --ntasks=1                     # Number of tasks per node (keep at 1)
#SBATCH --cpus-per-task=16             # CPU cores requested per task (change for threaded jobs)
#SBATCH --mem=128G                     # Memory needed per node (total)
#SBATCH --error=jobid_%j.err           # File to which STDERR will be written, including job ID
#SBATCH --output=jobid_%j.out          # File to which STDOUT will be written, including job ID
#SBATCH --mail-type=ALL                # Type of email notification (BEGIN, END, FAIL, ALL)

module load cellranger/2.1.1

cellranger aggr \
  --id=aggr \
  --csv=aggr.csv \
  --normalize=mapped \
  --localcores=$SLURM_CPUS_PER_TASK \
  --localmem=128 \
  --nosecondary
