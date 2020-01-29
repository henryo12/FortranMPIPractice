# Makefile for MatrixAddition

OBJ = matrixDAXPY.o
CC = ifort
PROG = daxpy
CFLAGS =

$(PROG): $(OBJ)
	$(CC) $(CFLAGS) -o $(PROG) $(OBJ)

matrixAddition.o: matrixDAXPY.f90
	$(CC) $(CFLAGS) -c matrixDAXPY.f90

#$(PROG).o: $(PROG).f90
#	$(CC) $(CFLAGS) -c $(PROG).f90

clean:
	rm -f *.o *.mod

cleanall:
	rm -f *.o *.mod $(PROG)

