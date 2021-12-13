@utils/readcol.pro

tic

readcol, '13/data.dat', data, columns=2
readcol, '13/folds.dat', folds, columns=2

dlines = (size(data))[2]
flines = (size(folds))[2]

paper = intarr(max(data[0,*]+1), max(data[1,*]+1))

for n = 0, dlines-1 do paper[data[0,n],data[1,n]] = 1

for n = 0, flines-1 do begin
    fold = folds[*,n]
    if fold[0] eq 0 then paper = paper[0:*,0:fold[1]-1] or reverse(paper[0:*,fold[1]-1:*],2)
    if fold[0] eq 1 then paper = paper[0:fold[1]-1,0:*] or reverse(paper[fold[1]+1:*,0:*],1)

    if n eq 0 then print, 'Challenge 1:', total(paper eq 1)
endfor

print, 'Challenge 2:'
for n=0, (size(paper))[2] -1 do print, strjoin(strtrim(string(paper[0:*,n]),2))

toc

end