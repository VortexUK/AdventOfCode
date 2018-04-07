import os
import json
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def do_array(array,part2):
    total = 0
    for item in range(0, len(array)):
        item_type = type(array[item])
        if item_type is int:
            total += array[item]
        if item_type is list:
            total += do_array(array[item], part2)
        if item_type is dict:
            total += do_object(array[item], part2)
    return total


def do_object(object,part2):
    total = 0
    ignore_object = False
    for key in object.keys():
        item_type = type(object[key])
        if item_type is int:
            total += object[key]
        if item_type is list:
            total += do_array(object[key], part2)
        if item_type is dict:
            total += do_object(object[key], part2)
        if item_type is str:
            if part2 is True and object[key] == "red":
                ignore_object = True
    if ignore_object:
        total = 0
    return total


inp = (file_get_contents(cwd + "\input.txt"))[0]
json_data = json.loads(inp)
print do_array(json_data, False)
print do_array(json_data, True)
