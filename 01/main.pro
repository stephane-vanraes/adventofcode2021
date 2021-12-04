;file = '01/test.dat'
file = '01/data.dat'

data = intarr(file_lines(file))

openr, lun, file, /get_lun
readf, lun, data
close, lun

; Challenge 1
compare = shift(data, 1)
print, 'result 1:', n_elements(where(data gt compare))

; Challenge 2
data = data + shift(data,1) + shift(data,2)
compare = shift(data, 1)
print, 'result 2:', n_elements(where(data gt compare))

end