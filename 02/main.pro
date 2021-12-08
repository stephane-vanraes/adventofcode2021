@utils/readcol.pro

tic

readcol, '02/data.dat', data, columns=2

; Challenge 1

horizontal = TOTAL(data[1, WHERE(data[0, *] eq 0)])
vertical = TOTAL(data[1, *] # TRANSPOSE(data[0, *]))

print,  horizontal * vertical, format='("Challenge 1: ", d20.0)'

; Challenge 2
; horizontal is the same
aims = TOTAL(data[0,*] * TRANSPOSE(data[1,*]), /CUMULATIVE)
forwards = 1d - data[0,*] ^ 2d ; changes all zeros into 1 and vice-versa
vertical = (forwards * data[1,*]) # TRANSPOSE(aims)

print,  horizontal * vertical, format='("Challenge 2: ", d20.0)'

toc

end