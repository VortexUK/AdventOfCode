import hashlib


def find_five_zeros(starter):
    i = 0
    while not m.hexdigest().startswith("00000"):
        i += 1
        m = hashlib.md5()
        m.update(starter + str(i))
    print m.hexdigest()


def find_six_zeros(starter):
    i = 0
    while not m.hexdigest().startswith("00000"):
        i += 1
        m = hashlib.md5()
        m.update(starter + str(i))
    print m.hexdigest()


find_five_zeros("ckczppom")
find_six_zeros("ckczppom")
