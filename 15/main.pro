@utils/readcol.pro

tic

;readcol, '15/test.dat', risks, columns=10, format='(10I1)'
readcol, '15/data.dat', risks, columns=100, format='(100I1)'

mul = 5

c = (size(risks))[2]
r = (size(risks))[1]

trisks = replicate(0, c*mul, r*mul)
for i=0,mul-1 do begin
 for j=0,mul-1 do begin
    x = i*r
    y = j*c
    trisks[x:x+c-1,y:y+c-1] = risks + i + j
 endfor
endfor

correct = where(trisks gt 9)
if correct[0] ne -1 then trisks[where(trisks gt 9)] -= 9
risks = trisks

c = (size(risks))[2]
r = (size(risks))[1]

visited = replicate(0,c, r)
weight = replicate(999999d,c, r)
weight[0,0] = 0

i = 0
j = 0
next = max(weight)

while visited[c-1,r-1] eq 0 do begin
    print, i, j, n_elements(where(visited eq 0))
    next2 = next
    for n=-1,1,2 do begin
        if i+n ge 0 and i+n lt c then begin
            if visited[i+n,j] ne 1 and weight(i+n,j) gt weight[i,j] + risks[i+n,j] then begin
                weight[i+n,j] = weight[i,j] + risks[i+n,j]         
                if weight[i+n,j] lt next then begin
                    next2 = weight[i+n,j]
                    i = i + n
                    continue
                endif    
            endif
        endif
        if j+n ge 0 and j+n lt r then begin
            if visited[i,j+n] ne 1 and weight(i,j+n) gt weight[i,j] + risks[i,j+n] then begin
                weight[i,j+n] = weight[i,j] + risks[i,j+n]        
                if weight[i,j+n] lt next then begin
                    next2 = weight[i,j+n]
                    j = j + n
                    continue
                endif          
            endif
        endif
    endfor
    if next eq next2 then begin
        visited[i,j] = 1
        next = where(weight eq min(weight[where(visited ne 1)]) and visited ne 1)
        next = next[0]
        i = next mod r
        j = next / r
    endif else next = next2
endwhile

;print, weight

print, 'Challenge 1:', weight[c-1, r-1]
toc

end
