

def convert(item):
    if "'" in item:
        parts = item.split("'")
        if len(parts[1]) > 0:
            parts[1] = str(int(parts[1])/float(16))
            return float(parts[0])+float(parts[1])
        else:
            return parts[0]
    else:
        return item

f = open('./raw.txt', 'r')
for line in f:
    #print line,
    items = line.split()
    newitems = [str(convert(item)) for item in items]
    print ' '.join(newitems)


f.close()

