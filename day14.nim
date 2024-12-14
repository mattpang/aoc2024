# brew install nim
# nim r day14.nim

import strutils, math,sequtils
import std/tables, std/enumerate

# let lines = readFile("sample.txt").splitLines() 
# let w = 11
# let h=7
# let tmax = 100

let lines = readFile("inputs/input-14.txt").splitLines() 
let w= 101
let h=103
let tmax = 100

type
  Row = array[4, int]
  xy = array[2,int]




var bots =  newSeq[Row]()

var i=0
for line in lines:
    # parse the bot xy and vel
    let p = line.split(' ')[0]
    let xy = p.replace("p=","").split(",").map(parseInt)
    let v = line.split(' ')[1]
    let vel = v.replace("v=","").split(",").map(parseInt)

    bots.add([xy[0],xy[1],vel[0],vel[1]])
    # echo bots[i]
    i=i+1

for i in countup(0,bots.len()-1):
    # x
    bots[i][0] = (bots[i][0]+tmax*bots[i][2]) mod w
    bots[i][1] = (bots[i][1]+tmax*bots[i][3]) mod h
    
    if bots[i][0]<0:
        bots[i][0] = w+bots[i][0]
    
    if bots[i][1]<0:
        bots[i][1] = h+bots[i][1]


var quads : array[4, int]
for i in countup(0,bots.len()-1):
    # count how many in quadrants.
    # echo "bot:",i+1,bots[i]
    if (bots[i][0] < w div 2) and (bots[i][1] < h div 2):
        quads[0] = quads[0]+1
    elif (bots[i][0] > w div 2) and (bots[i][1] < h div 2):
        quads[1] = quads[1]+1
    elif (bots[i][0] < w div 2) and (bots[i][1] > h div 2):
        quads[2] = quads[2]+1
    elif (bots[i][0] > w div 2) and (bots[i][1] > h div 2):
        quads[3] = quads[3]+1


if h==7:
    assert quads == [1,3,4,1]
echo "part 1:",prod(quads)

# part 2, maybe there's a trunk?
var counter: seq[int] = @[]

for t in countup(0,10000):
    # for each step, see how many neighbouring bots there are
    counter.add(0)
    
    var grid = newSeq[seq[int]](w)
    for i in 0 ..< w:
        grid[i].newSeq(h)
        for j in 0 ..< h:
            grid[i][j] = 0  

    
    for i in countup(0,bots.len()-1):
        var x = (bots[i][0]+t*bots[i][2]) mod w
        var y = (bots[i][1]+t*bots[i][3]) mod h
        
        if x<0:
            x = w+x
        if y<0:
            y = h+y
        
        grid[x][y]=1

    # after this count how many have a nearby in the 8 squares. 
    # for every position. if the ±1,0,±1 is also >0 +1
    for x in countup(2,w-3):
        for y in countup(2,h-3):
            if grid[x][y]!=0:
                for i in countup(-2,2):
                    for j in countup(-2,2):
                        if grid[x+i][y+j]==1 and (i!=0 and j!=0):
                            counter[t]=counter[t]+1

               

var max_pos =0 
var max_val =0 
for c,cval in enumerate(counter):
    if cval>=max_val:
        max_pos = c
        max_val = cval

echo "part 2:",max_pos+100, " val:",max_val
