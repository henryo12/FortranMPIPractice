# Simple DAXPY program with MPI using PGI compiler
## Includes step to invert matrix at the end
```
./build.sh
qsub execute.sh
```

TODO:
Make inverse step a function
Use different compiler flags to optimize the code
Create a static and shared library out of the code
Write a small test program to use created libraries
Secondary task - Add OpenACC directives in your code to extract parallelism on GPUs
Enable GPU-direct to communicate directly between GPUs without involving the host
