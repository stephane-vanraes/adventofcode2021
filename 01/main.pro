@utils/readcol.pro
tic

readcol, '01/data.dat', data, c

size = n_elements(data)

print, 'Challenge 1', total(data[1:size-1] gt data[0:size-2])
print, 'Challenge 2', total(data[3:size-1] gt data[0:size-4])

toc

end