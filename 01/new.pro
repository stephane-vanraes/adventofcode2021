file = '01/data.dat'
data = intarr(file_lines(file))

openr, lun, file, /get_lun
readf, lun, data
close, lun

c = n_elements(data)

print, 'Challenge 1:', total(data gt shift(data, 1))

for i=1, c - 2 do data[c-i] = total(data[c-i-2:c-i])

print, 'Challenge 2', total(data[2,*] gt shift(data[2,*], 1))


end