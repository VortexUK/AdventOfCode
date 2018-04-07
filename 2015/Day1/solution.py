import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return f.read()


def count_brackets(input):
    result = input.count('(') - input.count(')')
    return result


def move_elevator(command):
    if command == '(':
        return 1
    if command == ')':
        return -1


def get_basement_floor_index(input):
    floor = 0
    index = 0
    for action in input:
        floor += move_elevator(action)
        index += 1
        if floor == -1:
            return index


inp = file_get_contents(cwd + "\input.txt")
print count_brackets(inp)
print get_basement_floor_index(inp)
