import json
names=[]
with open("anime.json",'r') as handle:
    x= json.load(handle)
    names = [data['name'] for data in x]
with open("anime.json",'w+') as handle:

    json.dump(names,handle,indent=4)