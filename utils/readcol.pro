pro readcol, file, output, size, columns=columns, format=format
    if not keyword_set(columns) then columns = 1

    output = intarr(columns, file_lines(file))
    
    openr, lun, file, /get_lun

    if keyword_set(format) then begin
        size = file_lines(file)
        readf, lun, output, format=format
    endif else begin
        size = file_lines(file) / columns
        readf, lun, output
    endelse
    
    close, lun 
    free_lun, lun
end
