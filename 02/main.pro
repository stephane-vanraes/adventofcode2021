@utils/readcol.pro

tic

readcol, '02/data.dat', data, columns=2

; Challenge 1

horizontal = total(data[1, where(data[0, *] eq 0)])
vertical = total(data[1, *] * data[0, *])

print,  horizontal * vertical, format='("Challenge 1: ", d20.0)'

; Challenge 2
aims = total(data[1,*] * data[0,*], /CUMULATIVE)
forwards = 1d - data[0,*] ^ 2d ; changes all zeros into 1 and vice-versa
vertical = (forwards * data[1,*]) # transpose(aims)

print,  horizontal * vertical, format='("Challenge 2: ", d20.0)'

toc


end