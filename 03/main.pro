@utils/bin2dec.pro
@utils/readcol.pro

tic

readcol, '03/data.dat', data, length, columns = 12, format='(12I1)'

print, length

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

toc

end