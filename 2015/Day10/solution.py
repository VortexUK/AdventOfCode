import re
import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def get_next_iter(number):
    int_array = list(number)
    current_number = -1
    current_count = 0
    new_number = ""
    index =0
    number_length = len(number)
    for integer in int_array:
        index += 1
        if current_number == -1:
            current_number = integer
            current_count += 1
        elif current_number == integer:
            current_count += 1
        elif current_number != integer:
            new_number += str(current_count) + str(current_number)
            current_number = integer
            current_count = 1
    new_number += str(current_count) + str(current_number)
    return new_number


inp = (file_get_contents(cwd + "\input.txt"))[0]
for i in range(0, 40):
    inp = get_next_iter(str(inp))
print len(inp)
# Go an extra 10 for part 2:
for i in range(0, 10):
    inp = get_next_iter(str(inp))
print len(inp)