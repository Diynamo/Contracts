import random
import math
import time

#value -> Random from VRF
value =  74879308384894146919965198749562386123000361831513865325398127120639312039709
#print(value)

l = []
index = 0
while True:
	random_value = random.randint(1,value/random.randint(1,1000000))
	new_value = value/random_value
	new_value = math.floor(new_value) - 1
	if(new_value < 10001):
		if new_value not in l:
			l.append(new_value)
			index = index +1
			if(index > 10000):
				break
        
#print(l)
print(l.index(0))
print(l.index(1000))
print(l.index(10000))
