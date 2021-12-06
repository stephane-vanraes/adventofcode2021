@utils/readcol.pro

readcol, '06/data.dat', data

days = 256

daynumbers = indgen(days)

spawns = dblarr(days)

for i=0, n_elements(data) - 1 do begin
    spawns[where(daynumbers mod 7 eq data[i])] += 1d
endfor

for i=0, days-1 do begin
    spawndays = where(daynumbers mod 7 eq (i + 9) mod 7 and daynumbers ge i + 9)
    spawns[spawndays] += spawns[i]
endfor

print, n_elements(data) + total(spawns[0:79]), format='("Challenge 1: ", d20.0)'
print, n_elements(data) + total(spawns), format='("Challenge 2: ", d20.0)'


end