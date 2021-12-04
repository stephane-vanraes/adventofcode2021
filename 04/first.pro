file = '04/data-pulls.dat'
length = file_lines(file)
pulls = intarr(file_lines(file))

openr, 1, file
readf, 1, pulls
close, 1

file = '04/data-cards.dat'
length = file_lines(file)
boards = intarr(5,5,length/5)

openr, 2, file

line = intarr(5)
for i=0, length-1 do begin
  readf, 2, line
  boards[*,i mod 5,i/5] = line
end

close, 2

game = boards
count = (size(boards))[3]

found = 0
winner = [0,0]
pullnumber = -1

while (found ne 1) do begin
    pullnumber++

    game[where(game eq pulls[pullnumber])] = -1

    for i=0, count-1 do begin
        test = game[*,*,i] ## [1,1,1,1,1]
        search = where(test eq -5)

        test2 = game[*,*,i] # [1,1,1,1,1]
        search2 = where(test2 eq -5)
        if (search2 ne -1 or search ne -1) then begin
            found = found + 1
            winner = game[*,*,i]
        endif

    end    
end

winner[where(winner eq -1)] = 0
print, 'Challenge 1', total(winner) * pulls[pullnumber]

end