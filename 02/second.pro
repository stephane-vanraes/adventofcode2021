; PREPROCESSED FILE
; forward = 0
; down = 1
; up = -1

file = '02/preprocessed.dat'
data = intarr(2, file_lines(file))

openr, lun, file, /get_lun
readf, lun, data
close, lun

horizontal = TOTAL(data[1, WHERE(data[0, *] eq forward)])
vertical = ((1-(data[0, *]^2)) * data[1,*]) # TRANSPOSE(TOTAL(data[1,*] * TRANSPOSE(data[0, *]), /CUMULATIVE))

print, horizontal, vertical
print, horizontal * vertical

end