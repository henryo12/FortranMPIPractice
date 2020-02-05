
DIR=/glade/work/omeara/FortranMPIPractice/DAXPY_MPI_Inv

cd $DIR
source setup
echo $(module list)

make cleanall
make
