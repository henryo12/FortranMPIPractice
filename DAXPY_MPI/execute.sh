#!/bin/bash
#PBS -N daxpy
#PBS -A NTDD0002
#PBS -l walltime=00:00:15
#PBS -q economy
#PBS -j oe
#PBS -l select=1:ncpus=4:mpiprocs=4

DIR=/glade/work/omeara/FortranMPIPractice/DAXPY_MPI
cd $DIR

source setup
echo $(module list)

#./daxpy
#mpiexec_mpt ./daxpy
mpirun -np 4 ./daxpy
