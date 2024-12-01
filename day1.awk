# written in awk, run with 
# gawk -f day1.awk ./inputs/input-1.txt
# brew install gawk
function abs(v) {v += 0; return v < 0 ? -v : v}
BEGIN {

print("Reading file:",ARGV[1])
id = 0 
while (getline < ARGV[1])
{
split($0,ft,"   ");
data1[id]=ft[1];
data2[id]=ft[2];
id++
}
close(ARGV[1]);
n1 = asort(data1)
n2 = asort(data2)

tally =0 
for (i = 1; i <= n1; i++) {
    tally = tally + (abs(data1[i]-data2[i]))
}

print("Part 1:",tally)
# count number of freq in data2
for (i = 1; i <= n1; i++) {
    val =  data2[i]
    seen[val]++
}

summed_freq=0
for (i = 1; i <= n1; i++) {
    summed_freq = summed_freq + data1[i]*seen[data1[i]]
}

print("Part 2:",summed_freq)

} 
END{}
