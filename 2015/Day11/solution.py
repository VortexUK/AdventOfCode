import re
import os
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


def get_next_password(current_password):
    password_split = list(current_password)
    last_char_index = len(current_password) -1
    if (password_split[last_char_index]) != 'z':
        password_split[last_char_index] = chr(ord(password_split[last_char_index])+1)
        new_password = "".join(password_split)
    else:
        new_password = get_next_password("".join(password_split[0:last_char_index])) + "a"
    return new_password

def get_next_valid_password (starting_password):
    first_rule = r"[^iol]"
    second_rule = r"(.)\1.*(.)\2"
    third_rule = r"abc|bcd|cde|def|efg|fgh|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz"
    next_password_not_found = True
    new_password = starting_password
    while next_password_not_found:
        new_password = get_next_password(new_password)
        if re.search(first_rule, new_password):
            if re.search(second_rule, new_password):
                if re.search(third_rule, new_password):
                    next_password_not_found = False
    return new_password


inp = (file_get_contents(cwd + "\input.txt"))[0]
nextpassword = get_next_valid_password(inp)
print nextpassword
print get_next_valid_password(nextpassword)
