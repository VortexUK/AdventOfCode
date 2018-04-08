import os
import re
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def get_difference(int_array):
    smallest = min(int(s) for s in int_array)
    largest = max(int(s) for s in int_array)
    return largest-smallest


def get_divisible(int_array):
    division_result = 0
    for i in range(0,len(int_array)):
        for j in range(0,len(int_array)):
            if i != j:
                if int(int_array[i]) % int(int_array[j]) == 0:
                    division_result = int(int_array[i])/int(int_array[j])
    return division_result


def get_spreadsheet_checksum(spreadsheet):
    checksum = 0
    for line in spreadsheet:
        line_split = re.split(r"\s+", line)
        checksum += get_difference(line_split)
    return checksum


def get_spreadsheet_division(spreadsheet):
    checksum = 0
    for line in spreadsheet:
        line_split = re.split(r"\s+", line)
        checksum += get_divisible(line_split)
    return checksum


inp = (file_get_contents(cwd + "\input.txt"))
print get_spreadsheet_checksum(inp)
print get_spreadsheet_division(inp)
