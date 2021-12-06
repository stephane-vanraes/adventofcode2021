data = [0,1,2,3,4,5,6,7,8]
spawns = replicate(0, n_elements(data))
firsts = replicate(0, n_elements(data))
days = 14

for n=0, n_elements(data) - 1 do begin
    if data[n] le 6 then first = n mod 7 else first = n mod 9
    spawntime = (days - first)
    spawned = (spawntime / 7) + 1
    ;spawned = (spawned ^ 2) / 2
    spawns[n] = (spawned * (spawned + 1)) / 2
endfor

print, spawns
print, firsts
end