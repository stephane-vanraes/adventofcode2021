data = intarr(file_lines('01/data.dat'))

openr, lun, '01/data.dat', /get_lun
readf, lun, data
close, lun

print, n_elements(where(data gt shift(data, 1)))

end