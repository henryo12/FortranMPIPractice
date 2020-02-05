
PROGRAM matrixAddition
    use printMat
    
    IMPLICIT NONE
    include 'mpif.h'
    INTEGER, PARAMETER :: N=1000
    REAL, DIMENSION(N,N) :: A,B,C,Cinv
    INTEGER i,j
    REAL :: alpha, start, finish, timeInit, timeDaxpy, timeInv, timeTotal
    INTEGER numRanks, rank, ierr, colsPerRank, firstCol, dest, source
    REAL, DIMENSION(N) :: work
    INTEGER, DIMENSION(N) :: ipiv
    INTEGER info

    ! External procedures defined in LAPACK
    external SGETRF
    external SGETRI

    ! Note: this is called from each rank
    print *, 'Matrix size: ', shape(A)
    
    ! Initialize MPI
    call MPI_INIT(ierr)
    ! Find number of MPI processes
    call MPI_COMM_SIZE(MPI_COMM_WORLD,numRanks,ierr)
    ! Find process ID of current rank
    call MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

    ! Simple check to verify mpi working
    print *, 'Hello from process ',rank,' of ',numRanks

    ! Master rank should choose and alpha and send to workers
    if(rank == 0) then
        call RANDOM_NUMBER(alpha)
        do dest=1,(numRanks-1)
            call MPI_SEND(alpha,1,MPI_REAL,dest,1,MPI_COMM_WORLD,ierr)
        end do
    else
        call MPI_RECV(alpha,1,MPI_REAL,0,1,MPI_COMM_WORLD,MPI_STATUS_IGNORE,ierr)
    end if
    ! alpha should now be the same in each rank
    print *, 'alpha in rank ', rank, ' equals: ', alpha

    ! Initialize matrices
    call RANDOM_SEED()
    call CPU_TIME(start)
    ! Fortran is column major
    colsPerRank = N/numRanks
    firstCol = rank*colsPerRank+1
    ! Each rank should initialize colsPerRank columns
    do j=firstCol,(firstCol+colsPerRank-1)
        do i=1,N
            CALL RANDOM_NUMBER(A(i,j))
            CALL RANDOM_NUMBER(B(i,j))
        end do
    end do
    call CPU_TIME(finish)
    timeInit=finish-start
    print *, 'Rank ', rank, ' initialization time: ', timeInit

    ! Compute C=alpha*A+B
    call CPU_TIME(start)
    ! Fast method without using MPI:
    !C=alpha*A+B
    do j=firstCol,(firstCol+colsPerRank-1)
        do i=1,N
            C(i,j)=alpha*A(i,j)+B(i,j)
        end do
        print *, 'Computing column ',j,' in rank ',rank
    end do
    call CPU_TIME(finish)
    timeDaxpy=finish-start
    !print *, 'Rank ', rank, ' DAXPY time: ', timeDaxpy

    ! Send data to rank 0
    ! Send/receive the first row element in each rank's first column
    ! Number of sent/received values is N*colsPerRank
    if(rank == 0) then
        do source=1,(numRanks-1)
            print *,'Receiving column ',source*colsPerRank+1,' from rank ',source
            call MPI_RECV(C(1,source*colsPerRank+1),N*colsPerRank,MPI_REAL,source,2,MPI_COMM_WORLD,MPI_STATUS_IGNORE,ierr)
        end do
    else
        print *,'Sending column ',firstCol,' from rank ',rank
        call MPI_SEND(C(1,firstCol),N*colsPerRank,MPI_REAL,0,2,MPI_COMM_WORLD,ierr)
    end if

    ! Take inverse of the matrix
    !call CPU_TIME(start)
    if(rank == 0) then
        Cinv=C
        call SGETRF(N,N,Cinv,N,ipiv,info)
        if (info /= 0) then
            !stop 'Matrix is numerically singular!'
            print *, 'Matrix is singular!!!!!!'
        end if
        ! DGETRI computes the inverse of a matrix using the LU factorization
        ! computed by DGETRF.
        call SGETRI(N,Cinv,N, ipiv, work, n, info)
        if (info /= 0) then
            !stop 'Matrix inversion failed!'
            print *, 'Matrix inversion failed!!!!'
        end if
    end if
    !call CPU_TIME(finish)
    !timeInv=finish-start
    !print *, 'Rank ', rank, ' inverse time: ', timeInv

    
    timeTotal=timeInit+timeDaxpy!+timeInv
    print *, 'Rank ', rank, ' total time: ', timeTotal
    
    ! Can be used to lock and hold each process at this line until all processes have reached this line
    !call MPI_BARRIER(MPI_COMM_WORLD,ierr)

    ! Call function from printMat.mod to display part of C
    if(rank==0) then
        print *, "Matrix C"
        print *, 'C width ',size(C,1)
        print *, 'C height ',size(C,2)
        print *, 'C sizeof ',sizeof(C)
        CALL displayMat(C,8,8)
        print *, "Matrix Cinv"
        print *, 'Cinv width ',size(Cinv,1)
        print *, 'Cinv height ',size(Cinv,2)
        print *, 'Cinv sizeof ',sizeof(Cinv)
        CALL displayMat(Cinv,8,8)
    end if
    
    ! Clean up MPI environment and end MPI communications
    call MPI_FINALIZE(ierr)
    

END PROGRAM matrixAddition

