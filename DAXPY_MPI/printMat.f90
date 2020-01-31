! Function to print a matrix
! Fortran functions return a single output,
! whereas subroutines modify the input variables

module printMat
implicit none

CONTAINS
    subroutine displayMat(mat,m,n)
        implicit none
        integer, intent(in) :: m,n
        real, dimension(m,n), intent(in) :: mat
        INTEGER i,j

        do i=1,m
            do j=1,n
                write (*,"(F8.6,A2)",advance="no") mat(i,j), '  '
            end do
            print *
        end do
    end subroutine displayMat



end module printMat


