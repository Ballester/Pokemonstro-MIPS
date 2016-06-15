import Image
import numpy as np

def rgb_to_hex(rgb):
    return '#%02x%02x%02x' % rgb
    
im = Image.open('skills/polidori/gosmon_jubrets.png').convert("RGB")
im = np.array(im)

for i in range(0, im.shape[0]):
    print '.word ',
    for j in range(0, im.shape[1]):
        rgb = tuple(im[i][j])
        hexa = rgb_to_hex(rgb)
        hexa = '0x00' + str(hexa[1:])
        if j < im.shape[1]-1:
            print hexa + ', ',
        else:
            print hexa,
    print
