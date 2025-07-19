program curva_luz
    implicit none
    integer, parameter :: n = 6
    real :: tempo(n) = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5]
    real :: magnitude(n) = [12.5, 12.7, 12.4, 12.6, 12.3, 12.5]
    real :: media
    integer :: i

    media = sum(magnitude) / n
    print *, 'Magnitude média: ', media

    real :: erro(n) = [0.05, 0.04, 0.06, 0.05, 0.04, 0.05]
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
