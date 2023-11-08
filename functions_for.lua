function sum(a,b)
    print(a+b)
end
function print_nums(a,b)
    for i = a, b, 1 do
        io.write(i .. " ") -- .. is used as a concatenation operator to combin
    end
    io.write("\n")
end
print(sum(3,2))
print_nums(3,7)
