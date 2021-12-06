@utils/readcol.pro

readcol, '06/data.dat', data

days = 256
spawns = dblarr(days)
for i=0, n_elements(data) - 1 do begin
    j = data[i]
    while j lt days do begin
        spawns[j] += 1d
        j+=7
    endwhile
endfor

for i=0, days-1 do begin
    spawned = spawns[i]
    j = i + 9
    while j lt days do begin
        spawns[j] += spawned
        j+=7
    endwhile
endfor
print, 'Challenge 1:', double(n_elements(data) + total(spawns)), format='(d50.0)'

end