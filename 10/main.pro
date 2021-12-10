@utils/str2char.pro

tic

file = '10/data.dat'
size = file_lines(file)

symbols = '([{<)]}>'
results = dblarr(2, size)

openr, lun, file, /get_lun
    for n=0, size - 1 do begin
        line = ''
        readf, lun, line
        str2char, line, data
        
        expected = list()

        for m=0, n_elements(data) - 1 do begin
            cur = strpos(symbols, data[m])
            if (cur le 3) then begin
                if cur ne n_elements(data) - 1 then expected.add, cur + 4
            endif 
            if (cur ge 4) then begin
                ex = expected[n_elements(expected) - 1]
                if cur eq ex then expected.remove, n_elements(expected) - 1
                if cur ne ex then begin
                    score = [3d,57d,1197d,25137d]
                    faultyness = score[cur-4]
                    results[*,n] = [1,faultyness]
                    break
                endif
            endif
            if m eq n_elements(data) - 1 then begin
                incompleteness = 0d
                for k = 1, n_elements(expected) do begin
                    ex = expected[n_elements(expected) - k]
                    incompleteness *= 5d 
                    incompleteness += ex - 3d
                endfor
                results[*,n] = [0,incompleteness]
            endif
        endfor
    endfor
close, lun
free_lun, lun

print,  total(results[1,where(results[0,*] eq 1)]), format='("Challenge 1: ", d20.0)'
print,  median(results[1,where(results[0,*] eq 0)]), format='("Challenge 2: ", d20.0)'

toc

end