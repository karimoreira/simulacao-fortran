program curva_luz
    implicit none
    integer, parameter :: n = 6
    real :: tempo(n)
    real :: magnitude(n)
    real :: erro(n)
    real :: media
    integer :: i
    character(len=100) :: filename
    filename = 'dados.txt'
    open(unit=10, file=filename, status='old', action='read')
    do i = 1, n
        read(10, *) tempo(i), magnitude(i), erro(i)
    end do
    close(10)

    media = sum(magnitude) / n
    print *, 'Magnitude média: ', media

    real :: soma_pesos, media_ponderada
    soma_pesos = sum(1.0 / erro**2)
    media_ponderada = sum(magnitude / erro**2) / soma_pesos
    print *, 'Magnitude média ponderada: ', media_ponderada

    real :: desvio
    desvio = sqrt(sum((magnitude - media)**2) / (n-1))
    print *, 'Desvio padrão: ', desvio

    ! Ajuste linear (método dos mínimos quadrados)
    real :: soma_t, soma_m, soma_tt, soma_tm, a, b
    soma_t = sum(tempo)
    soma_m = sum(magnitude)
    soma_tt = sum(tempo * tempo)
    soma_tm = sum(tempo * magnitude)
    a = (n * soma_tm - soma_t * soma_m) / (n * soma_tt - soma_t**2)
    b = (soma_m * soma_tt - soma_t * soma_tm) / (n * soma_tt - soma_t**2)
    print *, 'Ajuste linear: magnitude = ', a, '* tempo + ', b

end program curva_luz
