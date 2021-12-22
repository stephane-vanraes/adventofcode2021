tic

throws = (indgen(102) mod 100) + 1
;players = [[4,0d],[8,0d]]
players = [[7,0d],[4,0d]]
roll = 0
rollc = 0
p = 0

print, players[0,p]

while (where(players[1,*] ge 1000))[0] eq -1 do begin
    players[0,p] += total(throws[roll:roll+2])
    if (players[0,p] mod 10 eq 0) then players[1,p] += 10 else players[1,p] += players[0,p] mod 10
    rollc += 3
    roll = rollc mod 100
    p = (++p) mod 2
endwhile

loser = players[1, where(players[0,*] lt 1000)]
print, 'Challenge 1:', rollc, loser, rollc * loser

toc

end