def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def unwrap_present(present):
    dimensions = sorted([int(_) for _ in present.split("x")])
    return dimensions


def get_present_footage(present):
    dimensions = unwrap_present(present)
    footage = ((dimensions[0] * dimensions[1]) * 2)\
              + ((dimensions[1] * dimensions[2]) * 2)\
              + ((dimensions[0] * dimensions[2]) * 2)\
              + (dimensions[0] * dimensions[1])
    return footage


def get_required_paper(input):
    total_footage = 0
    for present in input:
        total_footage += get_present_footage(present)
    return total_footage


def get_present_ribbon(present):
    dimensions = unwrap_present(present)
    footage = (dimensions[0] * 2)\
              + (dimensions[1] * 2)\
              + (dimensions[0] * dimensions[1] * dimensions[2])
    return footage


def get_required_ribbon(input):
    total_footage = 0
    for present in input:
        total_footage += get_present_ribbon(present)
    return total_footage


inp = file_get_contents("S:\Prod\AdventOfCode\BenM\PyCharm\Day2.txt")
print get_required_paper(inp)
print get_required_ribbon(inp)
