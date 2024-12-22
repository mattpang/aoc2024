// brew install vlang
// v run day22.v
import os 
import math 

fn mix_prune(x i64, s i64) i64{
	mut sec:=x^s
	sec = sec & ((1 << 24) - 1)
	return sec
}

fn run(i i64) i64 {
	mut s := i
	mut a :=i64(1)
	// times 64
	a=s<<6
	s = mix_prune(a,s)
	// div 32 
	a=s>>5
	s = mix_prune(a,s)
	
	// times 2048
	a = s<<11
	s = mix_prune(a,s)
	return s 
}

fn main(){
	//  read the file. 
	mut f := os.read_file('./inputs/input-22.txt') or { panic(err) }
    lines := f.split('\n')

    mut numbers := []i64{}
    for line in lines {
        if line.trim_space().len > 0 { // Check for empty lines
            number := line.trim_space().i64()
            numbers << number
        }
    }

	mut total := i64(0)
	for num in numbers{

		mut x := num
		for _ in 0..2000 {
			x = run(x)
		}
		// println(x)
		total+=x
	}

	println('part 1 ${total}') 


// part 2, compute all these. window th diff to get seq. 
// count the total of all the seq. 
// in a 2000 run, if i see the seq twice, I have to skip it. can only take the first. 
// 
	mut score := map[string]i64{} 
	for num in numbers{

		mut x := num
		mut digit := math.abs(x) % 10 
		mut last_digit := digit


		mut last4 := []i64{}
		// always insert at the start, then we can pop the oldest
		last4.prepend(digit)


		mut seq := []i64{}
		mut seen := []string{}
			for _ in 0..2000 {
				x = run(x)
				digit = math.abs(x) % 10
				seq << digit-last_digit
				d:=digit-last_digit
				// println("${digit},${last_digit}")
				last4.prepend(digit-last_digit)
				last_digit = digit

				if last4.len>4{
					last4.pop()
				}
				if last4.len==4{
					// accumlate the digit here. 
					// if its been in the map before, we can skip it
					entry := last4.map(it.str()).join(',')
					// the first time we see a 4 seq, we add the score
					if !(entry in seen){
						score[entry]+=digit
						seen<<entry
					}
				}
			}

	}

	mut max_value := i64(-1)
    mut max_key := ''
	for key, value in score {
        if value > max_value {
            max_value = value
			max_key = key
        }
    }

    // println('The largest seen $max_value at $max_key')
	println('part 2: ${max_value}')

}