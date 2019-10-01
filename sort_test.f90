
    program sort_test
        implicit none

    
        real(kind=8), dimension(:), allocatable :: a
        integer, dimension(:), allocatable :: sorted_indices
        
        integer :: n,npow
        integer :: i,ip,jp
        
        do n=1,10000
!         do npow=1,7
!             n=10**npow

            allocate(a(n))
            allocate(sorted_indices(n))
        
            call random_number(a)
            call merge_argsort(a,sorted_indices)

            do i=1,n-1
                ip = sorted_indices(i)
                jp = sorted_indices(i+1)
                if ( a(ip)<a(jp) ) then
                    print *,n,"FAILED"
                    stop
                endif
            end do
            print *,n,"PASSED"

            deallocate(a)
            deallocate(sorted_indices)
        
        end do
    
    contains
        subroutine merge_argsort(r,d)
            real(kind=8), intent(in), dimension(:) :: r
            integer, intent(out), dimension(size(r)) :: d
            
            integer, dimension(size(r)) :: il

            integer :: stepsize
            integer :: i,j,n,left,k,ksize
            
            n = size(r)
            
            do i=1,n
                d(i)=i
            end do
            
            if ( n==1 ) return
            
            stepsize = 1
            do while (stepsize<n)
                do left=1,n-stepsize,stepsize*2
                    i = left
                    j = left+stepsize
                    ksize = min(stepsize*2,n-left+1)
                    k=1
                
                    do while ( i<left+stepsize .and. j<left+ksize )
                        if ( r(d(i))>r(d(j)) ) then
                            il(k)=d(i)
                            i=i+1
                            k=k+1
                        else
                            il(k)=d(j)
                            j=j+1
                            k=k+1
                        endif
                    enddo
                
                    if ( i<left+stepsize ) then
                        ! fill up remaining from left
                        il(k:ksize) = d(i:left+stepsize-1)
                    else
                        ! fill up remaining from right
                        il(k:ksize) = d(j:left+ksize-1)
                    endif
                    d(left:left+ksize-1) = il(1:ksize)
                end do
                stepsize=stepsize*2
            end do

            return
        end subroutine    
        
    end program