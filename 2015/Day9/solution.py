import re
import os
import itertools
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


class City:

    def __init__(self, name):
        self.name = name
        self.distances = {}


    def add_distance(self, destination, distance):
        self.distances[destination] = int(distance)

def build_city_map(distances_unformatted):
    cities = {}
    for distance in distances_unformatted:
        splitstring = re.split(r"\s", distance)
        if splitstring[0] not in cities.keys():
            cities[splitstring[0]] = City(splitstring[0])
        if splitstring[2] not in cities.keys():
            cities[splitstring[2]] = City(splitstring[2])
        cities[splitstring[0]].add_distance(splitstring[2], splitstring[4])
        cities[splitstring[2]].add_distance(splitstring[0], splitstring[4])
    return cities


def get_part_a(distances_unformatted):
    # Build the city distance structure
    cities = build_city_map(distances_unformatted)
    # Get all possible routes
    possible_routes = list(itertools.permutations(cities.keys()))
    best_route = 99999
    for route in possible_routes:
        current_route_length = 0
        for i in range(0, (len(route) - 1)):
            current_route_length += cities[route[i]].distances[route[i+1]]
        if current_route_length < best_route:
            best_route = current_route_length
    print best_route


def get_part_b(distances_unformatted):
    # Build the city distance structure
    cities = build_city_map(distances_unformatted)
    # Get all possible routes
    possible_routes = list(itertools.permutations(cities.keys()))
    worst_route = 0
    for route in possible_routes:
        current_route_length = 0
        for i in range(0, (len(route) - 1)):
            current_route_length += cities[route[i]].distances[route[i+1]]
        if current_route_length > worst_route:
            worst_route = current_route_length
    print worst_route

inp = file_get_contents(cwd + "\input.txt")
get_part_a(inp)
get_part_b(inp)
