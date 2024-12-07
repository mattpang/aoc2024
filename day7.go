// go build day7.go; ./day7 sample.txt
package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func add(a int, b int) int {
	return a + b
}

func mult(a int, b int) int {
	return a * b
}

func concat(a int, b int) int {
	res, _ := strconv.Atoi(strconv.Itoa(a) + strconv.Itoa(b))
	return res
}

func contains(slice []int, num int) bool {
	for _, v := range slice {
		if v == num {
			return true
		}
	}
	return false
}

func main() {
	var filename = os.Args[1]
	// fmt.Println("Loading file:",filename)
	content, _ := os.ReadFile(filename)

	lines := strings.Split(string(content), "\n")
	total := 0
	var ops []func(int, int) int
	ops = append(ops, add)
	ops = append(ops, mult)

	for _, line := range lines {
		if len(line) == 0 {
			break
		}

		tmp := strings.Split(string(line), ": ")
		ans, _ := strconv.Atoi(tmp[0])
		nums := tmp[1]
		svals := strings.Split(string(nums), " ")

		var vals []int
		for _, str := range svals {
			num, _ := strconv.Atoi(str) // Convert string to int
			vals = append(vals, num)
		}

		var pot_ans []int

		for x := range vals {
			if x == 0 {
				pot_ans = append(pot_ans, vals[x])
			}
			if x == len(vals)-1 {
				break
			}
			// at each op, we split and make new entry of each combo to pot_ans
			var new_pot []int
			for o := range ops {
				for p := range pot_ans {
					new_pot = append(new_pot, ops[o](pot_ans[p], vals[x+1]))
				}
			}
			pot_ans = new_pot
		}
		if contains(pot_ans, ans) {
			total += ans
		}
	}
	fmt.Println(total)
	// no time to refactor
	ops = append(ops, concat)
	p2total := 0
	for _, line := range lines {
		if len(line) == 0 {
			break
		}

		tmp := strings.Split(string(line), ": ")
		ans, _ := strconv.Atoi(tmp[0])
		nums := tmp[1]
		svals := strings.Split(string(nums), " ")

		var vals []int
		for _, str := range svals {
			num, _ := strconv.Atoi(str) // Convert string to int
			vals = append(vals, num)
		}

		var pot_ans []int

		for x := range vals {
			if x == 0 {
				pot_ans = append(pot_ans, vals[x])
			}
			if x == len(vals)-1 {
				break
			}
			// at each op, we split and make new entry of each combo to pot_ans
			var new_pot []int
			for o := range ops {
				for p := range pot_ans {
					new_pot = append(new_pot, ops[o](pot_ans[p], vals[x+1]))
				}
			}
			pot_ans = new_pot
		}
		if contains(pot_ans, ans) {
			p2total += ans
		}
	}
	fmt.Println(p2total)

}
