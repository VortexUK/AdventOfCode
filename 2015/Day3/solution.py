from collections import Counter


def file_get_contents(filename):
    with open(filename) as f:
        return f.read()


def move_santa(direction, position):
    if direction == '^':
        position[1] += 1
    if direction == 'v':
        position[1] -= 1
    if direction == '>':
        position[0] += 1
    if direction == '<':
        position[0] -= 1
    return position


def deliver_presents(directions):
    santa_position = [0, 0]
    cnt = Counter()
    cnt[str(santa_position[0]) + "." + str(santa_position[1])] += 1
    for direction in directions:
        santa_position = move_santa(direction, santa_position)
        cnt[str(santa_position[0]) + "." + str(santa_position[1])] += 1
    print len(cnt)


def deliver_presentsrobo(directions):
    santa_position = [0, 0]
    robo_position = [0, 0]
    cnt = Counter()
    santasgo = True
    cnt[str(santa_position[0]) + "." + str(santa_position[1])] += 1
    cnt[str(robo_position[0]) + "." + str(robo_position[1])] += 1
    for direction in directions:
        if santasgo == True:
            santa_position = move_santa(direction, santa_position)
            cnt[str(santa_position[0]) + "." + str(santa_position[1])] += 1
        else:
            robo_position = move_santa(direction, robo_position)
            cnt[str(robo_position[0]) + "." + str(robo_position[1])] += 1
        santasgo = not santasgo
    print len(cnt)


inp = file_get_contents("S:\Prod\AdventOfCode\BenM\PyCharm\Day3.txt")
deliver_presents(inp)
deliver_presentsrobo(inp)
