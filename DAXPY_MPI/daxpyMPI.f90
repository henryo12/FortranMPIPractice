
PROGRAM matrixAddition
    use printMat
    
    IMPLICIT NONE
    include 'mpif.h'
    INTEGER, PARAMETER :: N=12
    REAL, DIMENSION(N,N) :: A,B,C
    INTEGER i,j
    REAL :: alpha, start, finish, timeInit, timeDaxpy, timeInv, timeTotal
    INTEGER numRanks, rank, ierr, colsPerRank, firstCol, dest, source


    print *, 'Matrix size: ', shape(A)
    
    ! Initialize MPI
    call MPI_INIT(ierr)
    ! Find number of MPI processes
    call MPI_COMM_SIZE(MPI_COMM_WORLD,numRanks,ierr)
    ! Find process ID of current rank
    call MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

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
    print *, 'alpha in rank ', rank, ' equals: ', alpha

    ! Initialize matrices
    call RANDOM_SEED()
    call CPU_TIME(start)
    colsPerRank = N/numRanks
    firstCol = rank*colsPerRank+1
    do j=firstCol,(firstCol+colsPerRank-1)
        do i=1,N
            !A(i,j)=i+j
            !B(i,j)=i*j
            !A(i,j)=RAND(start)
            !B(i,j)=RAND(start+1)
            CALL RANDOM_NUMBER(A(i,j))
            CALL RANDOM_NUMBER(B(i,j))
        end do
    end do
    call CPU_TIME(finish)
    timeInit=finish-start
    print *, 'Rank ', rank, ' initialization time: ', timeInit

    ! Compute C=alpha*A+B
    call CPU_TIME(start)
    !C=alpha*A+B
    do j=firstCol,(firstCol+colsPerRank-1)
        do i=1,N
            C(i,j)=alpha*A(i,j)+B(i,j)
            !write (*,*) C(i,j)
        end do
        print *, 'Computing column ',j,' in rank ',rank
    end do
    call CPU_TIME(finish)
    timeDaxpy=finish-start
    !print *, 'Rank ', rank, ' DAXPY time: ', timeDaxpy

    ! Send data to rank 0
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
    !
    !call CPU_TIME(finish)
    !timeInv=finish-start
    !print *, 'Rank ', rank, ' inverse time: ', timeInv

    
    timeTotal=timeInit+timeDaxpy!+timeInv
    print *, 'Rank ', rank, ' total time: ', timeTotal
    
    !call MPI_FINALIZE(ierr)
    !call MPI_BARRIER(MPI_COMM_WORLD,ierr)
    if(rank==0) then
        print *, "Matrix C"
        CALL displayMat(C,12,12)
    end if
    !print *, 'Rank ', rank, 'Matrix C'
    !CALL displayMat(C,12,12)
    call MPI_FINALIZE(ierr)
    

END PROGRAM matrixAddition

