tic

;file = '14/test.dat'
;polymer = 'NNCB'
file= '14/data.dat'
polymer = 'CKFFSCFSCBCKBPBCSPKP'

openr, lun, file, /get_lun
size = file_lines(file)
data = strarr(2, size)
readf, lun, data, format='(A2, " -> ", A1))'
close, lun 
free_lun, lun

hash = orderedhash(data[0,*], data[1,*])

for n=0, 39 do begin
    newpoly = strmid(polymer,0,1)

    for m=0, strlen(polymer) - 2 do begin
        set = strmid(polymer,m,2)
        inject = hash[set]
        newpoly += inject + strmid(set,1,1)
    endfor

    polymer = newpoly
endfor

polyarr = strarr(strlen(polymer))
for n=0, strlen(polymer) - 1 do polyarr[n] = strmid(polymer,n,1)

codes = polyarr[uniq(polyarr, sort(polyarr))]
codecount = intarr(n_elements(codes))
for c = 0, n_elements(codes) - 1 do codecount[c] = n_elements(where(polyarr eq codes[c]))

print, codes
print, codecount


print, 'Challenge 1:', max(codecount) - min(codecount)

toc

end
