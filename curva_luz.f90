program curva_luz
    implicit none
    integer, parameter :: n = 6
    real :: tempo(n) = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5]
    real :: magnitude(n) = [12.5, 12.7, 12.4, 12.6, 12.3, 12.5]
    real :: media
    integer :: i

    media = sum(magnitude) / n
    print *, 'Magnitude média: ', media
end program curva_luz
