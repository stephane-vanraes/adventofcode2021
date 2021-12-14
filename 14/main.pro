tic

file = '14/test.dat'
polymer = 'NNCB'
;file= '14/data.dat'
;polymer = 'CKFFSCFSCBCKBPBCSPKP'

openr, lun, file, /get_lun
size = file_lines(file)
data = strarr(2, size)
readf, lun, data, format='(A2, " -> ", A1))'
close, lun 
free_lun, lun

hash = orderedhash(data[0,*], data[1,*])
pairs = orderedhash(data[0,*], 0d)
keys = data[0,*]

chars = strarr(n_elements(keys) * 2)
for n=0, n_elements(keys) - 1, 2 do begin
    chars[n] = strmid(keys[n],0,1)
    chars[n+1] = strmid(keys[n],1,1)
endfor

chars = chars[uniq(chars, sort(chars))]
chars = orderedhash(chars, 0d)


for n=0, strlen(polymer) - 2 do begin
    char = strmid(polymer,n,1)
    code = strmid(polymer,n,2)
    pairs[code] += 1
    chars[char] += 1
endfor


for i=0, 39 do begin
    pairs2 = orderedhash(data[0,*],0)

    for n=0, n_elements(keys) - 1 do begin
        key = keys[n]
        pairs2[key] = pairs[key]
    endfor

    for n=0, n_elements(keys) - 1 do begin
        key = keys[n]
        inject = hash[key]
        elb = strmid(key,0,1) + inject
        ela = inject + strmid(key,1,1)
        chars[inject] += pairs[key]
        pairs2[elb] += pairs[key]
        pairs2[ela] += pairs[key]
        pairs2[key] -= pairs[key]
    endfor

    pairs = pairs2
endfor


counts = dblarr(n_elements(chars))
i=0
foreach char, chars do begin
    counts[i] = char
    i++
endforeach

counts = counts[where(counts gt 0)]

solution = max(counts) - min(counts) + 1
print, solution, format='("Challenge 2: ", d20.0)'

toc

end
