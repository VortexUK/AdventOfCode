import re


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def new_light_grid():
    w, h = 1000, 1000;
    light_grid = [[0 for x in range(w)] for y in range(h)]
    return light_grid


def format_command (unformatted_command):
    split_command = re.split(r"\s+(?!o)",unformatted_command)
    from_coords = re.split(r",", split_command[1])
    to_coords = re.split(r",", split_command[3])
    formatted_command = {}
    formatted_command["action"] = split_command[0]
    formatted_command["from_x"] = int(from_coords[0])
    formatted_command["to_x"] = int(to_coords[0])
    formatted_command["from_y"] = int(from_coords[1])
    formatted_command["to_y"] = int(to_coords[1])
    return formatted_command


def invoke_instruction1(current_state, unformatted_instruction):
    inst = format_command(unformatted_instruction)
    for x in range(inst["from_x"], (inst["to_x"] + 1)):
        for y in range(inst["from_y"], (inst["to_y"] + 1)):
            if inst["action"] == "turn off":
                current_state[x][y] = 0
            elif inst["action"] == "turn on":
                current_state[x][y] = 1
            elif inst["action"] == "toggle" and current_state[x][y] == 1:
                current_state[x][y] = 0
            elif inst["action"] == "toggle" and current_state[x][y] == 0:
                current_state[x][y] = 1
    return current_state


def invoke_instruction2(current_state, unformatted_instruction):
    inst = format_command(unformatted_instruction)
    for x in range(inst["from_x"], (inst["to_x"] + 1)):
        for y in range(inst["from_y"], (inst["to_y"] + 1)):
            if inst["action"] == "turn off":
                if current_state[x][y] != 0:
                    current_state[x][y] -= 1
            elif inst["action"] == "turn on":
                current_state[x][y] += 1
            elif inst["action"] == "toggle":
                current_state[x][y] += 2
    return current_state


def run_instructions(instructions, mode):
    light_grid = new_light_grid()
    if mode == 1:
        for instruction in instructions:
            light_grid = invoke_instruction1(light_grid, instruction)
    if mode == 2:
        for instruction in instructions:
            light_grid = invoke_instruction2(light_grid, instruction)
    print sum(sum(light_grid, []))


inp = file_get_contents("S:\Prod\AdventOfCode\BenM\PyCharm\Day6.txt")
run_instructions(inp, 1)
run_instructions(inp, 2)

