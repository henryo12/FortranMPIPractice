
PROGRAM matrixAddition
    IMPLICIT NONE

    INTEGER, PARAMETER :: N=10
    REAL, DIMENSION(N,N) :: A,B,C
    INTEGER i,j

    ! Initialize matrices
    do i=1,N
        do j=1,N
            A(i,j)=i+j
            B(i,j)=i*j
        end do
    end do

    print *, 'Matrix size: ', shape(A)

    do i=1,N
        do j=1,N
            C(i,j)=A(i,j)+B(i,j)
            write (*,*) C(i,j)
        end do
    end do

END PROGRAM matrixAddition

