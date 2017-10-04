from collections import namedtuple
def file_get_contents(filename):
    with open(filename) as f:
        return f.read()


def move_santa(direction,position):
    if direction == '^':
        position.y += 1
    if direction == 'v':
        position.y -= 1
    if direction == '>':
        position.x += 1
    if direction == '<':
        position.x -= 1
    return position

def deliver_presents(input):
    santa_position = namedtuple("santa_position","x , y")
    for direction in input

inp = file_get_contents("S:\Prod\AdventOfCode\BenM\PyCharm\Day3.txt")
