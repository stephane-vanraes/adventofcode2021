@utils/readcol.pro
@utils/bin2dec.pro

tic

;readcol, '20/test-alg.dat', alg, columns=512, format='(512I1)'
;readcol, '20/test-img.dat', timg, columns=5, format='(5I1)'
readcol, '20/data-alg.dat', alg, columns=512, format='(512I1)'
readcol, '20/data-img.dat', timg, columns=100, format='(100I1)'

maxruns = 2
expansion = 2 + (maxruns * 2)

cols = (size(timg))[1]
rows = (size(timg))[2]

img = intarr(rows+expansion, cols+expansion)
img[maxruns+1:cols+maxruns,maxruns+1:rows+maxruns] = timg

V = replicate(-1,rows+expansion, cols+expansion)

for runs=0, maxruns-1 do begin
    d = maxruns - runs
    for i=d, cols+expansion-d-1 do begin
        for j=d, rows+expansion-d-1 do begin
            bin2dec, reform(img[i-1:i+1,j-1:j+1],9,1), val
            V[i,j] = val
        endfor
    endfor

    img[where(V ge 0)] = alg[V[where(V ge 0)]]
endfor

print, total(img)

toc
end
