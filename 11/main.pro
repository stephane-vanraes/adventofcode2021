@utils/readcol.pro 
tic

readcol, '11/data.dat', data, columns=10, format='(10I1)'

temp = replicate(0, 12, 12)

flashes = 0d
step = 0

while 1 do begin
    data++
    while (where(data gt 9))[0] ne -1 do begin
        mask = data gt 9
        if step lt 100 then flashes += total(mask)
        data[where(data gt 9)] = -999
        temp[*,*] = 0
        temp[1:10,1:10] = mask

        for i=0, 9 do begin
            for j=0, 9 do begin
              data[i,j] += total(temp[i:i+2,j:j+2])
            end
        end
        
    endwhile
    
    if (where(data lt 0))[0] ne -1 then data[where(data lt 0)] = 0

    step++
    if total(data) eq 0 then break
endwhile


print, 'Challenge 1:', flashes
print, 'Challenge 2', step

toc
end
