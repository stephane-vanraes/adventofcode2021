@utils/readcol.pro

readcol, '02/data.dat', data, columns=2

; Challenge 1

horizontal = TOTAL(data[1, WHERE(data[0, *] eq 0)])
vertical = TOTAL(data[1, *] # TRANSPOSE(data[0, *]))

print, 'result 1:', horizontal * vertical

; Challenge 2
; horizontal is the same
aims = TOTAL(data[0,*] * TRANSPOSE(data[1,*]), /CUMULATIVE)
forwards = 1 - data[0,*] ^ 2 ; changes all zeros into 1 and vice-versa
vertical = (forwards * data[1,*]) # TRANSPOSE(aims)

print, 'result 2:', vertical * horizontal

end