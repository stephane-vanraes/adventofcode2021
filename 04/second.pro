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

winners = []
pullnumber = -1

while ((n_elements(winners) lt count) and (pullnumber lt 99)) do begin
    pullnumber++
    setter = where(game eq pulls[pullnumber])
    game[setter] = -1

    for i=0, count-1 do begin
        test = game[*,*,i] ## [1,1,1,1,1]
        search = where(test eq -5)

        test2 = game[*,*,i] # [1,1,1,1,1]
        search2 = where(test2 eq -5)
        if (search2[0] ne -1 or search[0] ne -1) then begin
            found = where(winners eq i)
            if (found[0] eq - 1) then winners = [winners, [i]]
        endif
    end
end

winner = winners[99]
winner = game[*,*,winner]
winner[where(winner eq -1)] = 0

print, 'winner:', winner
print, 'pulls', pullnumber
print, 'last pull', pulls[pullnumber]
print, 'winner total', total(winner)
print, 'result', total(winner) * pulls[pullnumber]

end