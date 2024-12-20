// bun run day20.ts

const path = "inputs/input-20.txt";

const file = Bun.file(path);
const lines = await file.text();

const grid: string[] = lines.split("\n");
const height: int = grid.length;
const width: int = grid[0].length;


var start = { x: 0, y: 0 };
var end = { x: 0, y: 0 };

for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
        if (grid[y][x] === "S") {
            start = { x, y };
        } else if (grid[y][x] === "E") {
            end = { x, y };
        }
    }
}


function move(x, y, condition) {
    var neighbors = [
        x > 0 ? [x - 1, y] : null,
        x < grid[0].length - 1 ? [x + 1, y] : null,
        y > 0 ? [x, y - 1] : null,
        y < grid.length - 1 ? [x, y + 1] : null,
    ];
    return neighbors.filter(
        (k) => k !== null && condition(k[0], k[1], grid[k[1]][k[0]])
    );
}

const pathPositions = [];
const visited = new Set();
const queue = [{ ...start }];
while (queue.length > 0) {
    const { x, y } = queue.shift();
    pathPositions.push({ x, y });

    if (x === end.x && y === end.y) {
        break;
    }

    visited.add(`${x},${y}`);

    const nei = move(x, y, (x, y, v) => {
        return v !== "#" && !visited.has(`${x},${y}`);
    });

    queue.push({ x: nei[0][0], y: nei[0][1] });
}

let skips = 0;
let savedArr = {};
for (let firstPos = 0; firstPos < pathPositions.length - 1; firstPos++) {
    for (
        let secondPos = firstPos + 1;
        secondPos < pathPositions.length;
        secondPos++
    ) {
        const savedBySkipping = secondPos - firstPos;

        //check if they have the same x or y
        if (
            pathPositions[firstPos].x === pathPositions[secondPos].x ||
            pathPositions[firstPos].y === pathPositions[secondPos].y
        ) {
            //check if they are 3 units or less away
            let xDiff = Math.abs(
                pathPositions[firstPos].x - pathPositions[secondPos].x
            );
            let yDiff = Math.abs(
                pathPositions[firstPos].y - pathPositions[secondPos].y
            );

            if (xDiff + yDiff <= 2) {
                const saved = savedBySkipping - (xDiff + yDiff);

                //if (saved > 0) console.log("saved", saved);

                if (saved >= 100) {
                    skips++;

                    savedArr[saved] = savedArr[saved] ? savedArr[saved] + 1 : 1;
                    //start a frequency counter
                }
            }
        }
    }
}

console.log("part 1:", skips);


skips = 0;
savedArr = {};
for (let firstPos = 0; firstPos < pathPositions.length - 1; firstPos++) {
    for (
        let secondPos = firstPos + 1;
        secondPos < pathPositions.length;
        secondPos++
    ) {
        const savedBySkipping = secondPos - firstPos;


        let xDiff = Math.abs(
            pathPositions[firstPos].x - pathPositions[secondPos].x
        );
        let yDiff = Math.abs(
            pathPositions[firstPos].y - pathPositions[secondPos].y
        );

        if (xDiff + yDiff <= 20) {
            const saved = savedBySkipping - (xDiff + yDiff);

            if (saved >= 100) {
                skips++;
                savedArr[saved] = savedArr[saved] ? savedArr[saved] + 1 : 1;

            }
        }
    }
}


console.log("part 2:", skips);
