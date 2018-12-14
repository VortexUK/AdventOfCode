#!/usr/bin/env python
from itertools import product
with open('Input.txt', 'r') as ifile:
    rlmap = [list(line.strip('\n')) for line in ifile]
carts = []
for y, x in product(range(len(rlmap)), range(len(rlmap[0]))):
    if rlmap[y][x] in '>v<^':
        crdir = '>v<^'.index(rlmap[y][x])
        rlmap[y][x] = '-|'[crdir & 1]
        carts.append([y, x, crdir, 0, True])
crash = False
iterations = 0
while len(carts) > 1:
    iterations += 1
    carts.sort(key=lambda i: tuple(i[:2]))
    for cart1 in carts:
        if not cart1[-1]:
            continue
        if rlmap[cart1[0]][cart1[1]] == '/':
            cart1[2] = (3, 2, 1, 0)[cart1[2]]
        elif rlmap[cart1[0]][cart1[1]] == '\\':
            cart1[2] = (1, 0, 3, 2)[cart1[2]]
        elif rlmap[cart1[0]][cart1[1]] == '+':
            cart1[2] = (cart1[2] + (-1, 0, 1)[cart1[3]]) & 3
            cart1[3] = (cart1[3] + 1) % 3
        cart1[0] += (0, 1, 0, -1)[cart1[2]]
        cart1[1] += (1, 0, -1, 0)[cart1[2]]
        for cart2 in carts:
            if cart2[-1] and cart1 is not cart2 and cart1[:2] == cart2[:2]:
                cart1[-1] = cart2[-1] = False
                if not crash:
                    crash = True
                    print(cart1[:2][::-1]) # 1
                break
    carts = list(filter(lambda i: i[-1], carts))
print(carts[0][:2][::-1]) # 2
print str(iterations)