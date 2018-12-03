import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def get_frequency_sum(numbers):
    return sum(numbers)


def get_double_frequency(numbers):
    frequency_not_found = True
    seen = list()
    current_sum = 0
    while frequency_not_found:
        for frequency in numbers:
            current_sum += frequency
            if current_sum in seen:
                return current_sum
            seen.append(current_sum)


inp = map(int, file_get_contents(cwd + "\input.txt"))
print "The Answer to Part 1 is: " + str(get_frequency_sum(inp))
print "The Answer to Part 2 is: " + str(get_double_frequency(inp))
