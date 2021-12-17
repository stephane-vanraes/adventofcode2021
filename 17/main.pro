tic

;target = [[20,30],[-5,-10]]
target = [[135, 155],[-78, -102]]

yval = intarr(3,599)
yval[0,*] = -10

for i=0, 599 do begin 
  v0 = i + target[1,1]
  v = v0
  y = 0
  t = 0
  while y gt target[0,1] do begin
    y += v
    v -= 1
    t++
  endwhile
  if y lt target[1,1] then continue
  t1 = t
  while y gt target[1,1] do begin
    y += v
    v -= 1
    t++
  endwhile

  yval[*,i] = [v0, t1, t-1]
endfor

yval[2,0] = 1
yval[2,where(yval[0,*] eq 0)] += 1
yval[2,where(yval[0,*] eq -1)] += 1
xval = intarr(3, target[1,0] + 1)

for i=0, target[1,0] do begin
  v0 = i
  v = v0
  x = 0
  t = 0
  while x lt target[0,0] and v ne 0 do begin
    x += v
    v -= 1
    if v le 0 then v = 0
    t++
  endwhile
  if x lt target[0,0] or x gt target[1,0] then continue
  if v eq 0 then begin
    xval[*,i] = [v0, t, 999]
    continue
  endif
  t1 = t
  while x le target[1,0] and v ne 0 do begin
    x += v
    v -= 1
    if v le 0 then v = 0
    t++
  endwhile
  if v eq 0 then begin
    xval[*,i] = [v0, t1, 999]
    continue
  endif
  xval[*,i] = [v0, t1, t - 1]  
endfor

xval[2, target[1,0]] = 1
count = 0

for n=1, target[1,0] do begin
  c=0
  if xval[0,n] eq 0 then continue
  min = xval[1,n]
  max = xval[2,n]
  for m=0, (size(yval))[2] - 1 do begin
    if yval[2,m] lt min then continue
    if yval[1,m] gt max then continue
    count++
    c++
  endfor
  print, n, c
endfor

print, count



yval2 = yval[*,where(yval[0,*] gt 0)]
maxy = max(yval2[0,*])
print, 'Challenge 1:', maxy * (maxy + 1) / 2

toc

end