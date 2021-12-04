@utils/readcol.pro

readcol, '04/data-pulls.dat', pulls, c_pulls
readcol, '04/data-cards.dat', lines, c_boards, columns=5

boards = replicate(1, 5,5,c_boards) * lines
found = 0
winners = []
pullnumber = -1

while (c_boards gt 0) do begin 
    ; Increase pullnumber
    pullnumber++

    ; find all corresponding numbers on cards
    hits = where(boards eq pulls[pullnumber], hitcount)
    if hitcount ne 0 then boards[hits] = -1
    
    ; run tests
    tests = []
    for i=0, c_boards-1 do begin
        ; the tests check if the sum of a row or column equals 5
        rows = (boards[*,*,i] ## [1,1,1,1,1]) eq -5
        cols = (boards[*,*,i] # [1,1,1,1,1]) eq -5
        ; find how many rows or columns are complete
        done = total(transpose(rows) or cols)
        ; add to the test array
        tests = [tests, done ne 0]
    end

    ; find all boards that are marked as won
    index = where(tests, fcount, complement=keep)

    ; if no new ones have won, go back to the while
    if fcount eq 0 then continue

    ; get the boards that are finished
    finished = boards[*,*,index]
    finsize = size(finished)

    ; differentiate between one winning or more
    if finsize[0] eq 2 then begin
        winner = create_struct('pull', pullnumber, 'board', finished)
        winners = [winners, winner]
    endif else begin
        for i=0, finsize[3] - 1 do begin
            winner = create_struct('pull', pullnumber, 'board', finished[*,*,i])
            winners = [winners, winner]
        endfor
    endelse

    ; Remove the boards that finished
    boards = boards[*,*,keep]
    c_boards -= total(tests)
end

winner = winners[0]
winner.board[where(winner.board eq -1)] = 0
print, 'Challenge 1', total(winner.board) * pulls[winner.pull]

loser = winners[n_elements(winners)-1]
loser.board[where(loser.board eq -1)] = 0
print, 'Challenge 2', total(loser.board) * pulls[loser.pull]

end