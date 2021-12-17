tic

;target = [[20,30],[-5,-10]]
target = [[135, 155],[-78, -102]]

ys = abs(target[1,1]) + 1
;; y t max
yval = intarr(5, ys * 2)
yval[0,*] = indgen(ys * 2) - ys

for n=0, (ys * 2)- 1 do begin
    m = n - ys
    t = 0
    y = 0
    if m ge 0 then begin
        repeat begin
            t++
            y = m + t*m - t*(t+1)/2
        endrep until y lt target[0,1]
    endif else begin
        repeat begin
            t++
            m2 = abs(m) - 1
            y = -(t*m2 + t*(t+1)/2)
        endrep until y le target[0,1]
    endelse
    if y lt target[1,1] then yval[1,n] = -1 else begin
        yval[1,n] = t
        yval[2,n] = m*(m+1)/2
    endelse
    if m ge 0 then begin    
        while y ge target[1,1] do begin 
            t++
            y = m + t*m - t*(t+1)/2
        endwhile
    endif else begin
        while y ge target[0,1] do begin 
            t++
            m2 = abs(m) - 1
            y = -(t*m2 + t*(t+1)/2)
        endwhile
    endelse
    yval[4,n] = t
endfor

maxy = max(where(yval[1,*] gt 0 and yval[0,*] gt 0))

print, 'Challenge 1:', yval[2, maxy]

xs = abs(target[1,0]) + 1
xval = intarr(3, xs)
xval[0,*] = indgen(xs)
for n=1, xs - 1 do begin
    if n*(n+1)/2 lt [target[0,0]] then begin
        xval[1,n] = 0
        continue
    endif
    x = 0
    k = n
    t = 0
    repeat begin
        x = (n-k+1)*(n+k)/2
        k--
        t++
    endrep until (x ge target[0,0]) or (x ge target[1,0]) or (k eq 0)
    if x gt target[1,0] then xval[1,n] = 0 else xval[1,n] = t
    while x lt target[1,0] and k ne 0 do begin
        x = (n-k+1)*(n+k)/2
        k--
        t++
    endwhile
    if k eq 0 then xval[2,n] = 9999 else xval[2,n] = t - 1
    if n eq target[1,0] then xval[2,n] = 1
end

xval = xval[*,where(xval[1,*] gt 0)]

count = 0
for n=0, (size(xval))[2] - 1 do begin
    c =  n_elements(where( $
        (xval[1,n] le yval[4,*] and yval[4,*] le xval[2,n] and yval[1,*] gt 0) or $
        (xval[1,n] le yval[1,*] and yval[1,*] le xval[2,n] and yval[1,*] gt 0)))
    ;print, xval[0,n], c
    count += c
endfor

;print, n_elements(where(yval[1,*] gt 0))
print, count
toc
end
