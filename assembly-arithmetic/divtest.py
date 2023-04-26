


for i in range(255):
    a = i >> 3
    b = a >> 2
    c = b >> 2
    d = (a-b+c)

    if not d==i//10:
        print(i, d, i//10)