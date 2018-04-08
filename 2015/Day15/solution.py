import os
import re
cwd = os.getcwd()


def file_get_contents(filename):
    with open(filename) as f:
        return [_.strip('\n') for _ in f.readlines()]


class Ingredient:

    def __init__(self, unformatted_ingredient):
        split_string = re.split(r"[:,]?\s+", unformatted_ingredient)
        self.name = split_string[0]
        self.capacity = int(split_string[2])
        self.durability = int(split_string[4])
        self.flavor = int(split_string[6])
        self.texture = int(split_string[8])
        self.calories = int(split_string[10])


def get_ingredients(unformatted_ingredients):
    ingredients = {}
    for ing in unformatted_ingredients:
        ing_split = re.split(r"[:,]?\s+", ing)
        ingredients[ing_split[0]] = Ingredient(ing)
    return ingredients


def get_mix_result(ingredients, recipe, part2):
    property_scores = {}
    ingredient_properties = ["capacity", "durability", "flavor", "texture"]
    calorie_count = 0
    for prop in ingredient_properties:
        property_scores[prop] = 0
        for ingredient in ingredients.keys():
            property_scores[prop] += getattr(ingredients[ingredient], prop) * recipe[ingredient]
    if part2 is True:
        for ingredient in ingredients.keys():
            calorie_count += getattr(ingredients[ingredient], "calories") * recipe[ingredient]
    score = 1
    if sum(1 for number in property_scores.values() if number < 0) > 0:
        score = 0
    elif part2 is True and calorie_count != 500:
        score = 0
    else:
        for x in property_scores.values():
            score *= x
    return score


def find_best_recipe(ingredients, part2):
    best_score = 0
    best_recipe = {}
    for i in range(0, 101):
        for j in range(0, (101-i)):
            for k in range(0, (101-(i+j))):
                for l in range(0, (101-(i+j+k))):
                    recipe = {}
                    recipe["Sprinkles"] = i
                    recipe["PeanutButter"] = j
                    recipe["Frosting"] = k
                    recipe["Sugar"] = l
                    current_score = get_mix_result(ingredients, recipe, part2)
                    if current_score > best_score:
                        best_score = current_score
                        best_recipe = recipe
    print best_score
    print best_recipe


inp = file_get_contents(cwd + "\input.txt")
ingredient_list = get_ingredients(inp)
find_best_recipe(ingredient_list, False)
find_best_recipe(ingredient_list, True)
