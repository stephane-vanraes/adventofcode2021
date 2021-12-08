@utils/readcol.pro

tic

readcol, '01/data.dat', data, c

print, 'Challenge 1:', total(data gt shift(data, 1))
data += shift(data,1) + shift(data, 2)
print, 'Challenge 2:', total(data gt shift(data, 1))

toc

end