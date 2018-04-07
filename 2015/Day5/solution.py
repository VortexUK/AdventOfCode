import re
import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def test_string(string_input):
    rule1 = re.compile(r"(?:[aeiou].*){3}", re.IGNORECASE)
    rule2 = re.compile(r"(.)\1", re.IGNORECASE)
    rule3 = re.compile(r"AB|CD|PQ|XY", re.IGNORECASE)
    nice_strings = []
    for child_string in string_input:
        if rule1.search(child_string):
            if rule2.search(child_string):
                if not rule3.search(child_string):
                    nice_strings.append(child_string)
    print len(nice_strings)


def test_string2(string_input):
    nice_strings = []
    rule4 = re.compile(r"(..).*\1")
    rule5 = re.compile(r"(.).\1")
    for child_string in string_input:
        if rule4.search(child_string):
            if rule5.search(child_string):
                nice_strings.append(child_string)
    print len(nice_strings)


inp = file_get_contents(cwd + "\input.txt")
test_string(inp)
test_string2(inp)
