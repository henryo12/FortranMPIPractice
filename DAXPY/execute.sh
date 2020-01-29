#!/bin/bash -l
# batch script to run an MPI application
#
#SBATCH --time=00:15:00
#SBATCH --job-name=daxpy
#SBATCH --account NTDD0002
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=task1.out
#SBATCH --error=task1.err

DIR=/glade/work/omeara/FortranMPIPractice/MatrixAddition
cd $DIR

source setup
echo $(module list)

./daxpy
