import re
import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def get_frequency_sum(inp):
    return sum(map(int, inp))


inp = file_get_contents(cwd + "\input.txt")
print "The Answer to Part 1 is: " + str(get_frequency_sum(inp))
