# Makefile for MatrixAddition

OBJ = daxpyMPI.o printMat.o
FC = mpif90
PROG = daxpy
FLAGS =
#export LD_LIBRARY_PATH=/glade/work/omeara/opt/lapack/lapack_pgiMPI/libPGI:$LD_LIBRARY_PATH
LIBS = -llapack -lblas
#LIBS = libblas.a liblapack.a
#LIBS = -L/glade/work/omeara/opt/lapack/lapack_pgiMPI/libPGI -llapack -lblas
#LIBS = -L/glade/u/home/spiver/LAPACK/pgiopenmpi/lib -llapack -lblas
# Lastly, create the executable from the object files
$(PROG): $(OBJ)
	$(FC) $(FLAGS) -o $(PROG) $(OBJ) $(LIBS)

# First, create matrixDAXPY.o from source file
daxpyMPI.o: daxpyMPI.f90 printMat.mod
	$(FC) $(FLAGS) -c daxpyMPI.f90 $(LIBS)

printMat.mod: printMat.o printMat.f90
	$(FC) $(FLAGS) -c printMat.f90 $(LIBS)

printMat.o: printMat.f90
	$(FC) $(FLAGS) -c printMat.f90 $(LIBS)
	echo $(LD_LIBRARY_PATH)

# Alternatively, infer that each .o file depends on a like-named .f90 file
# (still need to compile .mod files and executable)
#%.o: %.f90
#	$(FC) $(FLAGS) -c $<

clean:
	rm -f *.o *.mod

cleanall:
	rm -f *.o *.mod $(PROG)

