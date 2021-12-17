tic

target = [[20,30],[-10,-5]]

xval = intarr(3, target[1,0] + 1)
xval[0,*] = indgen(target[1,0] + 1)

for n=1, target[1,0] do begin
    if n*(n-1)/2 lt [target[0,0]] then begin
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
end

;xval = xval[*, where(xval[1,*] gt 0)]

yval = intarr(3, abs(target[0,1]) + 1)
yval[0,*] = indgen(abs(target[0,1]) + 1)

for n=1, abs(target[0,1]) do begin
print, '---', n, '---'
  y = 0
  k = 0
  repeat begin
    print, y
    y = -1*k*n - n*(k-1)/2
    k++
  endrep until y le target[1,1]
  yval[1,n] = k
end

print, yval

toc
end
