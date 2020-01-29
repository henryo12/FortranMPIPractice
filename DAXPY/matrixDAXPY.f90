
PROGRAM matrixAddition
    IMPLICIT NONE

    INTEGER, PARAMETER :: N=10
    REAL, DIMENSION(N,N) :: A,B,C
    INTEGER i,j
    REAL :: alpha, start, finish, timeInit, timeDaxpy, timeInv, timeTotal

    print *, 'Matrix size: ', shape(A)
    
    ! Initialize matrices
    call RANDOM_SEED()
    call CPU_TIME(start)
    do i=1,N
        do j=1,N
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
    print *, 'Initialization time: ', timeInit

    ! Compute C=alpha*A+B
    call RANDOM_NUMBER(alpha)
    call CPU_TIME(start)
    C=alpha*A+B
    !do i=1,N
    !    do j=1,N
    !        C(i,j)=alpha*A(i,j)+B(i,j)
    !        write (*,*) C(i,j)
    !    end do
    !end do
    call CPU_TIME(finish)
    timeDaxpy=finish-start
    print *, 'DAXPY time: ', timeDaxpy

    ! Take inverse of the matrix
    call CPU_TIME(start)
    
    call CPU_TIME(finish)
    timeInv=finish-start
    print *, 'Inverse time: ', timeInv

    
    timeTotal=timeInit+timeDaxpy+timeInv
    print *, 'Total time: ', timeTotal


END PROGRAM matrixAddition

