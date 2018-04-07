import re
import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


class stringrep:

    firstparta = r'\\\\(?!".)|\\"(?=.)|((?<!\\)|(?<=\\\\))\\(x[A-Za-z0-9]{2})'
    firstpartb = r'^"|"$'
    secondpart = r'\\|"'

    def __init__(self, string):
        self.string = string
        self.parta = re.sub(self.firstpartb, '', re.sub(self.firstparta, 'a', string))
        self.partb = '"' + re.sub(self.secondpart, 'aa', string) + '"'


def get_part_a(string_set):
    result = 0
    for string in string_set:
        formatted = stringrep(string)
        result += (len(formatted.string) - len(formatted.parta))
    print result


def get_part_b(string_set):
    result = 0
    for string in string_set:
        formatted = stringrep(string)
        result += (len(formatted.partb) - len(formatted.string))
    print result

inp = file_get_contents(cwd + "\input.txt")
get_part_a(inp)
get_part_b(inp)