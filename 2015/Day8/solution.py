import re
import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


class stringrep:

    firstparta = r'\\\\(?!".)|\\"(?=.)|\\(x[a-z0-9]{2})'
    firstpartb = r'"'
    secondpart = r'\\|"'

    def __init__(self,string):
        self.string = string
        self.parta = re.sub(self.firstpartb, '', re.sub(self.firstparta, 'a', string))
        self.partb = re.sub(self.secondpart, 'a', string) # not right - 2/1 length issues


inp = file_get_contents(cwd + "\input.txt")
