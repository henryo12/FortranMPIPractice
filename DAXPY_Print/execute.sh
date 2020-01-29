#!/bin/bash
#PBS -N daxpy
#PBS -A NTDD0002
#PBS -l walltime=00:00:30
#PBS -q economy
#PBS -j oe
#PBS -l select=2:ncpus=1:mpiprocs=1

DIR=/glade/work/omeara/FortranMPIPractice/DAXPY_Print
cd $DIR

source setup
echo $(module list)

./daxpy
#mpiexec_mpt ./daxpy
