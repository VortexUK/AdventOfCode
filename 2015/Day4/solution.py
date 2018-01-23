import hashlib


def file_get_contents(filename):
    with open(filename) as f:
        return f.read()


def find_five_zeros(starter):
    i = 0
    while not m.hexdigest().startswith("00000"):
        i += 1
        m = hashlib.md5()
        m.update(starter + str(i))
    print m.hexdigest()


def find_six_zeros(starter):
    i = 0
    while not m.hexdigest().startswith("00000"):
        i += 1
        m = hashlib.md5()
        m.update(starter + str(i))
    print m.hexdigest()


inp = file_get_contents("S:\Prod\AdventOfCode\BenM\PyCharm\Day3.txt")
find_five_zeros(inp)
find_six_zeros(inp)
