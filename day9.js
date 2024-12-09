// bun run day9.js

// const path = "./sample.txt";
const path = "./inputs/input-9.txt";
const file = Bun.file(path);
const line = await file.text();

function part1(line){
    let stack = [] 
    let id = 0
    let is_even = true
    for (var i in line){
        // every other is a file. when i is even
        is_even = (i%2==0)
        for (let j=0;j<parseInt(line[i]);j++){
            stack.push(is_even?id:'.')
        }
        if (is_even){
            id++
        }
    }

    //  swap teh dots around
    let val
    let total = 0
    for (var i in stack){
        if (stack[i]=='.'){
            // swap this with the last non '.' val
            while (true){
                val = stack.pop()
                if (val!='.'){
                    break
                }
            }
            stack.splice(i,1,val)
        }
    }


    for (i in stack){
        total+=i*stack[i]
    }
    return total
}

function part2(data){

    let stack = [] 
    let id = 0
    let is_even = true
    for (var i in data){
        // every other is a file. when i is even
        is_even = (i%2==0)
        for (let j=0;j<parseInt(data[i]);j++){
            stack.push(is_even?id:'.')
        }
        if (is_even){
            id++
        }
    }

    const stored = []
    const gaps = []
 
    stack.forEach((block, i) => {
        if (block !== ".") {
            stored[block] ??= { id: block, size: 0, positions: [] }
            stored[block].positions.push(i)
            stored[block].size++
        } else if (!gaps.length || gaps.at(-1).end + 1 !== i) {
            gaps.push({ start: i, end: i, size: 1 })
        } else {
            gaps.at(-1).end++
            gaps.at(-1).size++
        }
    })
 
    stored.reverse().forEach((file) => { 
        const { size, positions } = file
        const fileStartPos = positions[0]
        const targetSpan = gaps.find((span) => span.size >= size && span.end < fileStartPos)
 
        if (targetSpan) {
            positions.forEach((pos) => (stack[pos] = "."))
            for (let i = 0; i < size; i++) {
                stack[targetSpan.start + i] = file.id
            }
 
            if (targetSpan.size === size) {
                gaps.splice(gaps.indexOf(targetSpan), 1)
            } else {
                targetSpan.start += size
                targetSpan.size -= size
            }
 
            gaps.push({
                start: fileStartPos,
                end: fileStartPos + size - 1,
                size
            })
        }
    })


    return stack.reduce((checksum, block, index) => checksum + (block !== "." ? index * block : 0), 0)

}


console.log("Part 1:", part1(line))
console.log("Part 2:", part2(line))