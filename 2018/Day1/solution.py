import re
import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def get_frequency_sum(inp):
    return sum(inp)


inp = map(int, file_get_contents(cwd + "\input.txt"))
print "The Answer to Part 1 is: " + str(get_frequency_sum(inp))


frequency_not_found = True
dict = {}
current_sum = 0
while frequency_not_found:
    for frequency in inp:
        current_sum += frequency
        dict[str(current_sum)] += 1
        if dict[str(current_sum)] > 1:
            break


print current_sum