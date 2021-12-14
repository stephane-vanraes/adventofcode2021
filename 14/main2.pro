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
pairs = orderedhash(data[0,*], 0d)
keys = data[0,*]

codes = strarr(n_elements(keys) * 2)
for n=0, n_elements(keys) - 1, 2 do begin
    codes[n] = strmid(keys[n],0,1)
    codes[n+1] = strmid(keys[n],1,1)
endfor
codes = codes[uniq(codes, sort(codes))]

for n=0, strlen(polymer) - 2 do begin
    code = strmid(polymer,n,2)
    pairs[code] += 1
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
        pairs2[elb] += pairs[key]
        pairs2[ela] += pairs[key]
        pairs2[key] -= pairs[key]
    endfor

    pairs = pairs2
endfor
counts = dblarr(n_elements(codes)-1)

for n=0, n_elements(keys) - 1 do begin
    key = keys[n]
    k1 = strmid(key,0,1)
    k2 = strmid(key,1,1)
    c = pairs[key]
    p1 = where(codes eq k1)
    p2 = where(codes eq k2)
    counts[p1-1] += c
    counts[p2-1] += c
endfor
count = ceil(counts / 2)
solution = max(counts) - min(counts)
print, solution, format='("Challenge 2: ", d20.0)'

toc

end
