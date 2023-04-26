


for i in range(255):
    q = (i >> 1) + (i >> 2)
    q = q + (q >> 4)
    #q = q + (q >> 8)
    #q = q + (q >> 16)
    q = q >> 3
    r = i - q * 10
    if not q == i//10:
        print(i, q, r, i//10, q + ((r + 6) >> 4), q + (r > 9))