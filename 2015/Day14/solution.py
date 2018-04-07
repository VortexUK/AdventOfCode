import os
import re
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


class Reindeer:

    def __init__(self, string_statistic):
        split_string = re.split(r"\s+",string_statistic)
        self.name = split_string[0]
        self.speed = int(split_string[3])
        self.speed_time = int(split_string[6])
        self.rest_time = int(split_string[13])
        self.cycle_time = self.speed_time + self.rest_time
        self.distance_moved = 0
        self.points = 0

    def move(self, current_time):
        mod = (current_time % self.cycle_time)
        if 0 < mod <= self.speed_time:
            self.distance_moved += self.speed

    def add_point(self):
        self.points += 1


def get_reindeer_list(reindeer_statistics):
    reindeer_list = list()
    for reindeer_stat in reindeer_statistics:
        reindeer_list.append(Reindeer(reindeer_stat))
    return reindeer_list


def race_reindeer(reindeer_list):
    max_time = 2503
    for time in range(1, max_time):
        current_best_distance = 0
        for current_reindeer in reindeer_list:
            current_reindeer.move(time)
            if current_reindeer.distance_moved > current_best_distance:
                current_best_distance = current_reindeer.distance_moved
        for current_reindeer in reindeer_list:
            if current_reindeer.distance_moved == current_best_distance:
                current_reindeer.add_point()

    for current_reindeer in reindeer_list:
        print current_reindeer.name + ": " + str(current_reindeer.distance_moved) + " - "+ str(current_reindeer.points)


inp = file_get_contents(cwd + "\input.txt")
race_reindeer(get_reindeer_list(inp))
