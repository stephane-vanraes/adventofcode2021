@utils/readcol.pro

readcol, '06/test.dat', data
days = 18
data = transpose(data)

spawns = replicate(0, n_elements(data))

for n=0, n_elements(data) - 1 do begin
    if data[n] le 6 then first = n mod 7 else first = n mod 9
    spawntime = (days - first)
    spawned = (spawntime / 7) + 1
    spawns[n] += (spawned * ((spawntime / 6) + 1)) / 2
endfor


for n=1, days do begin
    data = data - 1
    willspawn = where(data eq -1)
    if willspawn[0] eq -1 then continue

    newfish = replicate(8, n_elements(willspawn))

    data = [data, newfish]
    data[where(data eq -1)] = 6
endfor

print, 'Challenge 1:', n_elements(data)
print, 'Challenge 1b:', 5 + total(spawns)
end