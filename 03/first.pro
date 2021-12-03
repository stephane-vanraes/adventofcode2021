@bin2dec.pro

file = 'data.dat'
length = file_lines(file)
data = intarr(12, file_lines(file))

openr, 1, file
readf, 1, data, format='(12I1)'
close, 1

res = data # replicate(1,length)
res[where(res lt length / 2)] = 0
res[where(res ne 0)] = 1

bin2dec, res, gamma
bin2dec, (res-1)^2, epsilon

print, 'gamma', gamma
print, 'epsilon', epsilon
print, 'power consumption', double(gamma * epsilon) 
end