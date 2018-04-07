import os
import re
import itertools
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


class Person:

    def __init__(self, name):
        self.name = name
        self.relationship = {}

    def add_happiness(self, person_name, happiness):
        self.relationship[person_name] = int(happiness)


def build_relationship_map(relationship_unformatted):
    relationships = {}
    for relationship in relationship_unformatted:
        splitstring = re.split(r"\s+", re.sub(r"\.", '', relationship))
        if splitstring[0] not in relationships.keys():
            relationships[splitstring[0]] = Person(splitstring[0])
        if splitstring[2] == "gain":
            relationships[splitstring[0]].add_happiness(splitstring[10], int(splitstring[3]))
        if splitstring[2] == "lose":
            relationships[splitstring[0]].add_happiness(splitstring[10], -int(splitstring[3]))
    return relationships


def get_best_table_setup(people_relationships,part2):
    relationship_map = build_relationship_map(people_relationships)
    if part2 is True:
        me = Person("me")
        other_diners = relationship_map.keys()
        relationship_map["me"] = me
        for diner in other_diners:
            relationship_map["me"].add_happiness(diner, 0)
            relationship_map[diner].add_happiness("me", 0)
    possible_setups = list(itertools.permutations(relationship_map.keys()))
    best_table = 0
    for table in possible_setups:
        current_table_score = 0
        possible_table = list(table)
        possible_table.append(possible_table[0])
        for i in range(0, (len(possible_table) - 1)):
            current_table_score += relationship_map[possible_table[i]].relationship[possible_table[i + 1]]
            current_table_score += relationship_map[possible_table[i+1]].relationship[possible_table[i]]
        if current_table_score >= best_table:
            best_table = current_table_score
    print best_table


inp = file_get_contents(cwd + "\input.txt")
get_best_table_setup(inp, False)
get_best_table_setup(inp, True)
