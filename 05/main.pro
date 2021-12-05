@utils/readcol.pro

readcol, '05/data.dat', data, col=4

grid = replicate(0,1000,1000)

K1 = data[0:1,*] - data[2:3,*]
K2 = K1[0,*] * K1[1,*]

straights = where(K2 eq 0, complement=diagonals)

for i=0, n_elements(straights)-1 do begin
    line = data[*, straights[i]]
    x1 = min([line[0],line[2]], max=x2)
    y1 = min([line[1],line[3]], max=y2)
    grid[x1:x2,y1:y2]++
end


print, 'Challenge 1:', n_elements(where(grid ge 2))

for i=0, n_elements(diagonals)-1 do begin
    line = data[*, diagonals[i]]
    x1 = min([line[0],line[2]], max=x2)
    y1 = min([line[1],line[3]], max=y2)

    ; figure out the rotation of the identity matrix
    rotation = 0
    if (line[0] gt line[2] and line[1] lt line[3]) then rotation = 1
    if (line[0] gt line[2] and line[1] gt line[3]) then rotation = 2
    if (line[0] lt line[2] and line[1] gt line[3]) then rotation = 3

    grid[x1:x2,y1:y2] += rotate(identity(x2 - x1 + 1), rotation)
end

print, 'Challenge 2:', n_elements(where(grid ge 2))

end