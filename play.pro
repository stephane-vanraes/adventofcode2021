file = 'test.dat'

output = strarr(file_lines(file))

openr, lun, file, /get_lun

size = file_lines(file)
readf, lun, output

close, lun 
free_lun, lun
tokens = strarr(13, file_lines(file))
for n=0, size-1 do tokens[*,n] = strsplit(output[n], /extract)

print, tokens

end