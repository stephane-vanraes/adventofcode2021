pro str2char, str, arr
    arr = strarr(strlen(str))

    for n=0, strlen(str) - 1 do begin
        arr[n]= strmid(str,n,1)
    endfor
end
