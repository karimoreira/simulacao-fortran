program curva_luz
    implicit none
    integer :: n, i, ios
    real, allocatable :: tempo(:), magnitude(:), erro(:)
    real :: media, soma_pesos, media_ponderada, desvio
    real :: soma_t, soma_m, soma_tt, soma_tm, a, b
    character(len=100) :: filename
    filename = 'dados.txt'

    n = 0
    open(unit=10, file=filename, status='old', action='read')
    do
        read(10, *, iostat=ios)
        if (ios /= 0) exit
        n = n + 1
    end do
    close(10)

    allocate(tempo(n), magnitude(n), erro(n))

    open(unit=10, file=filename, status='old', action='read')
    do i = 1, n
        read(10, *) tempo(i), magnitude(i), erro(i)
    end do
    close(10)

    media = sum(magnitude) / n
    print *, 'Magnitude media: ', media

    soma_pesos = sum(1.0 / erro**2)
    media_ponderada = sum(magnitude / erro**2) / soma_pesos
    print *, 'Magnitude media ponderada: ', media_ponderada

    desvio = sqrt(sum((magnitude - media)**2) / (n-1))
    print *, 'Desvio padrao: ', desvio

    soma_t = sum(tempo)
    soma_m = sum(magnitude)
    soma_tt = sum(tempo * tempo)
    soma_tm = sum(tempo * magnitude)
    a = (n * soma_tm - soma_t * soma_m) / (n * soma_tt - soma_t**2)
    b = (soma_m * soma_tt - soma_t * soma_tm) / (n * soma_tt - soma_t**2)
    print *, 'Ajuste linear: magnitude = ', a, '* tempo + ', b

end program curva_luz
