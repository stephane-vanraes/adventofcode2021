data = [1,2,4]

index = where(date eq 8, count)
if count ne 0 done = data[where(data eq 8)]
print, keep
data = data[keep]

print, data
print, done
end