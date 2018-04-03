import re


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def format_command(unformatted_command):
    split_command = re.split(r"\s+", unformatted_command)
    formatted_command = {}
    if split_command[0] == 'NOT':
        formatted_command["Operation"] = split_command[0]
        formatted_command["Input_A"] = split_command[1]
        formatted_command["Output"] = split_command[3]
    elif re.match(r"[0-9]+",split_command[0]) and split_command[1] == "->":
        formatted_command["Input_A"] = split_command[0]
        formatted_command["Operation"] = "START"
        formatted_command["Output"] = split_command[2]
    elif re.match(r"AND|OR|[LR]SHIFT",split_command[1]):
        formatted_command["Input_A"] = split_command[0]
        formatted_command["Operation"] = split_command[1]
        formatted_command["Input_B"] = split_command[2]
        formatted_command["Output"] = split_command[4]
    else:
        formatted_command["Input_A"] = split_command[0]
        formatted_command["Operation"] = "ASSIGN"
        formatted_command["Output"] = split_command[2]
    return formatted_command


def get_commands(inp):
    command_list = []
    for command in inp:
        command_list.append(format_command(command))
    return command_list


def initialise_circuit(starting_inputs):
    Circuit_Values = {}
    for Value in starting_inputs:
        Circuit_Values[Value["Output"]] = Value["Input_A"]
    return Circuit_Values


def add_to_circuit(instruction,circuit):
    if re.match(r"[A-Z]+",instruction["Input_A"]):
        input_a = circuit[instruction["Input_A"]]
    else:
        input_a = instruction["Input_A"]
    if re.match(r"[A-Z]+",instruction["Input_B"]):
        input_b = circuit[instruction["Input_B"]]
    else:
        input_b = instruction["Input_B"]
    output = instruction["Output"]
    if instruction["Operation"] == "AND":
        result = input_a & input_b
    elif instruction["Operation"] == "OR":
        result = input_a | input_b
    elif instruction["Operation"] == "LSHIFT":
        result = input_a << input_b
    elif instruction["Operation"] == "RSHIFT":
        result = input_a >> input_b
    elif instruction["Operation"] == "NOT":
        result = 65536 + ~input_a
    elif instruction["Operation"] == "ASSIGN":
        result = input_a
    circuit[output] = result
    return circuit



def connect_circuit(inputs):
    formatted_inputs = get_commands(inputs)
    starting_values = filter(lambda x: x["Operation"] == "START", formatted_inputs)
    circuit = initialise_circuit(starting_values)
    print circuit
    # Remove the start instructions:
    indexes = [i for i, x in enumerate(formatted_inputs) if x["Operation"] == 'START']
    for index in indexes:
        del formatted_inputs[index]
    no_end = True
    count = 0
    while no_end:
        print count
        count += 1
        for instruction in formatted_inputs:
            #print instruction
            if instruction["Input_A"] in circuit.keys() \
                    and instruction["Operation"] == "NOT":
                circuit = add_to_circuit(instruction, circuit)
                formatted_inputs.remove(instruction)
            elif instruction["Input_A"] in circuit.keys() \
                    and instruction["Input_B"] in circuit.keys() \
                    and instruction != "NOT":
                circuit = add_to_circuit(instruction, circuit)
                formatted_inputs.remove(instruction)
        if len(formatted_inputs) == 0:
            no_end = False
            print circuit["a"]


inp = file_get_contents("S:\Prod\AdventOfCode\BenM\PyCharm\Day7.txt")
connect_circuit(inp)
