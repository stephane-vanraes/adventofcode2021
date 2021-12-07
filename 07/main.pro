@utils/readcol.pro

readcol, '07/data.dat', data
crabs = n_elements(data)
width = max(data) + 1

moves = dblarr(crabs, width)
move = abs(shift(indgen(width * 2) - width, width))

for n=0, n_elements(data) -1 do moves[n, *] = shift(move, data[n])

totaler = replicate(1d, 1, crabs)

print, min(moves ## totaler), format='("Challenge 1: ", d20.0)'

moves = moves * (moves + 1d) / 2d

print, min(moves ## totaler), format='("Challenge 2: ", d20.0)'

end