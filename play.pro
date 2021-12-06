data = [0,1,2,3,4,5,6,7,8]
spawns = replicate(.5, n_elements(data))
firsts = replicate(0, n_elements(data))
days = 14

data = data + [0,0,0,1]

print, data
print, spawns
end