pro edge, bas, array, x, y, n
    if array[x,y] eq 9 then return
    if bas[x-1,y] lt n or bas[x+1,y] lt n or bas[x,y-1] lt n or bas[x,y+1] lt n then return

    bas[x,y] = n

    if bas[x-1,y] eq 999 then begin
        if array[x,y] lt array[x-1,y] then edge, bas, array, x-1, y, n
    endif
    
    if bas[x+1,y] eq 999 then begin
        if array[x,y] lt array[x+1,y] then edge, bas, array, x+1, y, n
    endif

    if bas[x,y-1] eq 999 then begin
        if array[x,y] lt array[x,y-1] then edge, bas, array, x, y-1, n
    endif
    
    if bas[x,y+1] eq 999 then begin
        if array[x,y] lt array[x,y+1] then edge, bas, array, x, y+1, n
    endif
end
