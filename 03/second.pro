@bin2dec.pro

file = 'data.dat'
length = file_lines(file)
data = intarr(12, file_lines(file))

openr, 1, file
readf, 1, data, format='(12I1)'
close, 1

oxigen = data
carbon = data

for i=0, 11 do begin
    oxifil = TOTAL(oxigen[i,*]) * 2 gt (n_elements(oxigen[i,*])) - 1
    oxigen = oxigen[*,where(oxigen[i,*] eq oxifil)]
    carfil = TOTAL(carbon[i,*]) * 2 gt (n_elements(carbon[i,*])) - 1
    carbon = carbon[*,where(carbon[i,*] ne carfil)]
end

print, oxigen
print, carbon

bin2dec, oxigen, oxi
bin2dec, carbon, car

print, double(oxi * car)

end