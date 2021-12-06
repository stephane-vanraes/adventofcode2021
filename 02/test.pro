data = [[0,10],[1,5],[2,5],[1,3],[2,2]]
actions = data[0, *]
values = data[1, *]

ups = data[data[where(actions eq 2)],*]

print, data[where(actions eq 2), *]



end