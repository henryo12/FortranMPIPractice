# FortranMPIPractice

**Goals:**  
First, write a DAXPY program, and then calculate the inverse of the result matrix using any of the existing linear algebra libraries.  
* The program should use MPI to extract the parallelism on Multiple CPU nodes  
* Use Fortran 90
* Build/Run the code with both Intel and PGI compiler
* Write a Makefile to build the code. Use different compiler flags to optimize the code
* For Intel-compiler build use the existing module on Cheyenne
* For PGI build, Install the community version of PGI on your own and build the OpenMPI library on top of PGI. Use your installation of PGI and OpenMPI to build your MPI program.
* For the above task, you need to understand the difference between PATH and LD_LIBRARY_PATH environment variables.
* Once your program successfully builds and runs, create a static and shared library out of the code.
* Write a small test program to use the libraries that you created  

Secondary task - Add OpenACC directives in your code to extract parallelism on GPUs  
* Enable GPU-direct to communicate directly between GPUs without involving the host (for this your MPI build must be CUDA aware). I will help you understand GPU-direct when you reach this phase.
