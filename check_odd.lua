--check if number is odd
num = io.read("*number")
if num then
    if num % 2 == 0 then
        print("Even")
    else
        print("Odd")
    end
else
    print("Invalid input")
end