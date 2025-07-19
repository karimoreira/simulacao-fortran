program curva_luz
    implicit none
    integer :: n, i, ios
    real, allocatable :: tempo(:), magnitude(:), erro(:)
    real, allocatable :: mag_sorted(:)
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

    allocate(tempo(n), magnitude(n), erro(n), mag_sorted(n))

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

    print *, 'Valor minimo: ', minval(magnitude)
    print *, 'Valor maximo: ', maxval(magnitude)

    mag_sorted = magnitude
    call sort_array(mag_sorted, n)
    if (mod(n,2) == 0) then
        print *, 'Mediana: ', (mag_sorted(n/2) + mag_sorted(n/2+1))/2.0
    else
        print *, 'Mediana: ', mag_sorted((n+1)/2)
    end if

    print *, 'Moda: ', moda(magnitude, n)

    print *, 'Q1: ', quartil(mag_sorted, n, 1)
    print *, 'Q2 (Mediana): ', quartil(mag_sorted, n, 2)
    print *, 'Q3: ', quartil(mag_sorted, n, 3)

    deallocate(tempo, magnitude, erro, mag_sorted)

contains

subroutine sort_array(arr, n)
    real, intent(inout) :: arr(:)
    integer, intent(in) :: n
    integer :: i, j
    real :: temp
    do i = 1, n-1
        do j = i+1, n
            if (arr(i) > arr(j)) then
                temp = arr(i)
                arr(i) = arr(j)
                arr(j) = temp
            end if
        end do
    end do
end subroutine sort_array

function moda(arr, n) result(mode)
    real, intent(in) :: arr(:)
    integer, intent(in) :: n
    real :: mode
    integer :: i, j, count, max_count
    mode = arr(1)
    max_count = 1
    do i = 1, n
        count = 1
        do j = i+1, n
            if (arr(j) == arr(i)) count = count + 1
        end do
        if (count > max_count) then
            max_count = count
            mode = arr(i)
        end if
    end do
end function moda

function quartil(arr, n, q) result(qv)
    real, intent(in) :: arr(:)
    integer, intent(in) :: n, q
    real :: qv
    real :: pos
    integer :: idx
    pos = q * (n+1) / 4.0
    idx = int(pos)
    if (idx < 1) idx = 1
    if (idx >= n) idx = n
    if (pos == idx) then
        qv = arr(idx)
    else
        qv = arr(idx) + (arr(idx+1) - arr(idx)) * (pos - idx)
    end if
end function quartil

end program curva_luz
