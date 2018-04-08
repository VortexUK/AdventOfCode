import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return f.read()


def get_part_1(integers):
    input_length = len(integers)
    sum = 0
    for i in range(0, input_length):
        if int(integers[(i-1)]) == int(integers[i]):
            sum += int(integers[i])
    return sum


def get_part_2(integers):
    input_length = len(integers)
    sum = 0
    for i in range(0, input_length):
        if int(integers[(i)]) == int(integers[((i+(input_length/2)) % input_length)]):
            sum += int(integers[i])
    return sum


inp = (file_get_contents(cwd + "\input.txt"))
result = get_part_1(inp)
print result
result = get_part_2(inp)
print result
