@utils/readcol.pro
@09/edge.pro

tic

cols = 100
rows = file_lines('09/data.dat')
colp = cols+2
rowp = rows+2

readcol, '09/data.dat', temp, columns=cols, format='(100I1)'

data = replicate(9,cols+2,rows+2)
data[1:cols,1:rows] = temp

lows = where(data lt shift(data,1,0) and data lt shift(data,-1,0) $
        and data lt shift(data,0,1) and data lt shift(data,0,-1))

basins = replicate(999,colp,rowp)
basinsize = fltarr(n_elements(lows))

for n=0, n_elements(lows)-1 do begin
    low = lows[n]
    edge, basins, data, low mod (colp), low / (colp), n
    basinsize[n] = n_elements(where(basins eq n))
endfor

basinsize = reverse(basinsize(sort(basinsize)))

print,  total(data[lows] + 1), format='("Challenge 1: ", d20.0)'
print, basinsize[0] * basinsize[1] * basinsize[2], format='("Challenge 2: ", d20.0)'

toc

end