# Makefile for MatrixAddition

OBJ = daxpyMPI.o printMat.o
FC = mpif90
PROG = daxpy
FLAGS =

# Lastly, create the executable from the object files
$(PROG): $(OBJ)
	$(FC) $(FLAGS) -o $(PROG) $(OBJ)

# First, create matrixDAXPY.o from source file
daxpyMPI.o: daxpyMPI.f90 printMat.mod
	$(FC) $(FLAGS) -c daxpyMPI.f90

printMat.mod: printMat.o printMat.f90
	$(FC) $(FLAGS) -c printMat.f90

printMat.o: printMat.f90
	$(FC) $(FLAGS) -c printMat.f90
# Alternatively, infer that each .o file depends on a like-named .f90 file
# (still need to compile .mod files and executable)
#%.o: %.f90
#	$(FC) $(FLAGS) -c $<

clean:
	rm -f *.o *.mod

cleanall:
	rm -f *.o *.mod $(PROG)

