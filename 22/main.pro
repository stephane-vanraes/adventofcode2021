@utils/readcol.pro

readcol, '22/test.dat', data, columns=7
lines = (size(data))[2]

tic

cube = intarr(101,101,101)
data[1:*,*] += 50

for n=0, lines-1 do begin
    if data[1,n] lt 0 then break
    if data[1,n] gt 100 then break
    cube[data[1,n]:data[2,n],data[3,n]:data[4,n],data[5,n]:data[6,n]] = data[0,n]
endfor

print, total(cube), format='("Challenge 1: ", d20.0)'

toc

end
