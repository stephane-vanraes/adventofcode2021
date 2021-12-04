print, 1466, 1491

file = '01/data.dat'
c = file_lines(file)

data = intarr(c)

openr, lun, file, /get_lun
readf, lun, data
close, lun

print, 'Challenge 1:', total(data gt shift(data, 1))

for i=1, c - 2 do data[c-i] = total(data[c-i-2:c-i])

print, 'Challenge 2:', total(data gt shift(data, 1)) - 2 ; wrapping correction


end