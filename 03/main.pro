@utils/bin2dec.pro

file = '03/data.dat'
length = file_lines(file)
data = intarr(12, length)

openr, 1, file
readf, 1, data, format='(12I1)'
close, 1

; Challenge 1
res = data # replicate(1,length)
res[where(res lt length / 2)] = 0
res[where(res ne 0)] = 1

bin2dec, res, gamma
bin2dec, (res-1)^2, epsilon

print, 'power consumption: ', double(gamma * epsilon) 

; Challenge 2
oxigen = data
carbon = data

for i=0, 11 do begin
    oxifil = TOTAL(oxigen[i,*]) * 2 gt (n_elements(oxigen[i,*])) - 1
    oxigen = oxigen[*,where(oxigen[i,*] eq oxifil)]
    carfil = TOTAL(carbon[i,*]) * 2 gt (n_elements(carbon[i,*])) - 1
    carbon = carbon[*,where(carbon[i,*] ne carfil)]
end

bin2dec, oxigen, oxi
bin2dec, carbon, car

print, 'life support', double(oxi * car)

end