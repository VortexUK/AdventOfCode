import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]




inp = file_get_contents(cwd + "\input.txt")
print "The Answer to Part 1 is: "
print "The Answer to Part 2 is: "
