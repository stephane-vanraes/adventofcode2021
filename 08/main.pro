file = '08/test.dat'

size = file_lines(file)
tokens = strarr(size)

openr, lun, file, /get_lun
readf, lun, input
close, lun 
free_lun, lun

tokens = strarr(15, size)
for n=0, size-1 do tokens[*,n] = strsplit(input[n], /extract)

counts = intarr(10)

for n=0, (size(tokens))[2] - 1 do begin
    ones = where(strlen(tokens[11:*,n]) eq 2)
    if ones[0] ne -1 then counts[1] += n_elements(ones)    
    fours = where(strlen(tokens[11:*,n]) eq 4)
    if fours[0] ne -1 then counts[4] += n_elements(fours)
    sevens = where(strlen(tokens[11:*,n]) eq 3)
    if sevens[0] ne -1 then counts[7] += n_elements(sevens)
    eights = where(strlen(tokens[11:*,n]) eq 7)
    if eights[0] ne -1 then counts[8] += n_elements(eights)
endfor

solution1= counts[1] + counts[4] + counts[7] + counts[8]

print, 'Challenge 1:', solution1

end