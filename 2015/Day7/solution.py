import re
import os
cwd = os.getcwd()


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
    output = instruction["Output"]
    if instruction["Operation"] == "START":
        circuit[output] = instruction["Input_A"]
    else:
        if re.match(r"[A-Za-z]+", instruction["Input_A"]):
            input_a = int(circuit[instruction["Input_A"]])
        else:
            input_a = int(instruction["Input_A"])
        if instruction["Operation"] != "NOT" and instruction["Operation"] != "ASSIGN":
            if re.match(r"[A-Za-z]+", instruction["Input_B"]):
                input_b = int(circuit[instruction["Input_B"]])
            else:
                input_b = int(instruction["Input_B"])
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
    circuit = {}
    no_end = True
    count = 0
    while no_end:
        for instruction in formatted_inputs:
            if instruction["Operation"] == "START":
                circuit = add_to_circuit(instruction, circuit)
                formatted_inputs.remove(instruction)
            elif (instruction["Input_A"] in circuit.keys() or re.match(r"[0-9]+", instruction["Input_A"])) \
                    and instruction["Operation"] in ["NOT", "ASSIGN"]:
                circuit = add_to_circuit(instruction, circuit)
                formatted_inputs.remove(instruction)
            elif "Input_B" in instruction.keys():
                if (instruction["Input_A"] in circuit.keys() or re.match(r"[0-9]+", instruction["Input_A"])) \
                        and (instruction["Input_B"] in circuit.keys() or re.match(r"[0-9]+", instruction["Input_B"])) \
                        and instruction != "NOT":
                    circuit = add_to_circuit(instruction, circuit)
                    formatted_inputs.remove(instruction)
        if len(formatted_inputs) == 0:
            no_end = False
            print "The answer is: a=" + str(circuit["a"])
    return str(circuit["a"])


inp = file_get_contents(cwd + "\input.txt")
part_1_answer = connect_circuit(inp) # Get the answer to the first Part
b_matcher = re.compile(".*-> b$")
current_b = filter(b_matcher.match, inp)
inp[inp.index(current_b[0])] = part_1_answer + " -> b"
part_2_answer = connect_circuit(inp) # Get the answer to the second Part