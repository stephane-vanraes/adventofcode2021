pro bin2dec, input, output
    temp = input
    output = 0
    n = n_elements(temp)
    temp = reverse(temp)
    for i=0, n-1 do output += temp[i]*(2L^i)
end