file = '08/test.dat'

tic

size = file_lines(file)
input = strarr(size)

openr, lun, file, /get_lun
readf, lun, input
close, lun 
free_lun, lun

tokens = strarr(15, size)
for n=0, size-1 do tokens[*,n] = strsplit(input[n], /extract)

tests = intarr(7,10,size)
values  = intarr(7,4,size)
strarr = ['a','b','c','d','e','f','g']

;loop through tokens and fill tests and values
for n=0, size-1 do begin
    for m=0, 9 do begin
        str = tokens[m,n]
        for s=0, 6 do begin
            tests[s,m,n] = strmatch(str, '*' + strarr[s] + '*')
        endfor
    endfor
    for m=0, 3 do begin
        str = tokens[m+11,n]
        for s=0, 6 do begin
            values[s,m,n] = strmatch(str, '*' + strarr[s] + '*')
        endfor
    endfor
endfor

;loop through each line and decrypt
decrypted = intarr(4,size)

for n=0, size-1 do begin
    T = tests[*,*,n]
    V = values[*,*,n]

    Tcount = T ## [1,1,1,1,1,1,1]
    key = intarr(7,10)
    key[*,1] = T[*,where(Tcount eq 2)]
    key[*,4] = T[*,where(Tcount eq 4)]
    key[*,7] = T[*,where(Tcount eq 3)]
    key[*,8] = T[*,where(Tcount eq 7)]
    ; 6 pieces and one missing from one
    key[*,6] = T[*, where(Tcount eq 6 and T ## key[*,1] eq 1)]
    A = (where(key[*,7] ne key[*,1]))[0]
    B = (where(key[*,1] eq 1 and key[*,6] ne key[*,1]))[0]
    C = (where(key[*,6] eq 1 and key[*,1] eq 1))[0]
    ; 6 pieces misses B
    key[*,5] = T[*, where(Tcount eq 5 and T[B,*] eq 0)]
    E = (where(key[*,6] ne key[*,5]))[0]
    ; 6 pieces misses E
    key[*,9] = T[*, where(Tcount eq 6 and T[E,*] eq 0)]
    ; 5 pieces misses C
    key[*,2] = T[*, where(Tcount eq 5 and T[C,*] eq 0)]
    FC = where(key[*,2] eq 0)
    F = FC[(where(FC ne C))[0]]
    ; 5 pieces not E and F
    key[*,3] = T[*, where(Tcount eq 5 and T[E,*] eq 0 and T[F,*] eq 0)]
    DC = where(key[*,4] eq 0)
    D = DC[(where(DC ne A and DC ne E))[0]]
    GC = [0,1,2,3,4,5,6]
    G = where(GC ne A and GC ne B and GC ne C and GC ne D and GC ne E and GC ne F)
    key[*,0] = T[*, where(Tcount eq 6 and T[G,*] eq 0)]
    
    for m=0, 3 do begin
        value = values[*,m,n]
        for i=0, 9 do begin
            if total(value and key[*,i]) eq total(key[*,i]) and total(key[*,i]) eq total(value) then decrypted[m,n] = i        
        endfor
    endfor

endfor

numbers = decrypted ## transpose([1000,100,10,1])

solution1 = n_elements(where(decrypted eq 1 or decrypted eq 4 or decrypted eq 7 or decrypted eq 8))
solution2 = total(numbers)

print, solution1, format='("Challenge 1: ", d20.0)'
print, solution2, format='("Challenge 2: ", d20.0)'

toc

end