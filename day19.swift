// swift day19.swift inputs/input-19.txt
// swiftc -O -o a.out  day19.swift
// time ./a.out inputs/input-19.txt
import Foundation

let filename = CommandLine.arguments[1]
let contents = try! String(contentsOfFile: filename)

var lines = contents.split(separator: "\n")
let towels = lines[0].split(separator: ", ").map { String($0) }
// print(towels)

lines.removeFirst()

var possible = 0
var combos = [0]


func possible_ways(line: String, towels: [String]) -> Int {
    // Use a memoization dictionary to store results of subproblems
    var memo = [String: Int]()

    func dfs(_ remaining: String) -> Int {
        if remaining.isEmpty {
            return 1
        }

        if let result = memo[remaining] {
            return result
        }

        var count = 0

        for towel in towels {
            if remaining.hasPrefix(towel) {
                let suffix = String(remaining.dropFirst(towel.count))
                count += dfs(suffix)
            }
        }

        memo[remaining] = count
        return count
    }

    return dfs(line)
}



for line in lines {

    let ways = possible_ways(line: String(line), towels: towels)
    if ways != 0 {
        possible += 1
        combos.append(ways)
        // print(line, "is possible")
    } else {
        // print(line, "is impossible")
    }

}

print("part 1",possible)
let sum_of_combos = combos.reduce(0,+)
print("part 2",sum_of_combos)