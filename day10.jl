# julia day10.ju
function get_score_and_rating(grid, head)
    paths = 0
    endpoints = Set()
    queue = [head]
    
    while !isempty(queue)
        current = pop!(queue)
        if grid[current] == 9
            paths += 1
            push!(endpoints, current)
            continue
        end
        
        directions = [1 + 0im, -1 + 0im, 0 + 1im, 0 - 1im]
        for d in directions
            next_pos = current + d
            if haskey(grid, next_pos) && grid[next_pos] == grid[current] + 1
                push!(queue, next_pos)
            end
        end
    end
    
    return [length(endpoints), paths]
end

input_file = open("./inputs/input-10.txt", "r")
input = read(input_file, String)
close(input_file)

grid = Dict{Complex{Int}, Int}()
for (b, r) in enumerate(split(input, "\n"))
    for (a, c) in enumerate(strip(r))
        grid[a + b * 1im] = parse(Int, c)
    end
end

trailheads = Set([p for p in keys(grid) if grid[p] == 0])
p1, p2 = sum(get_score_and_rating(grid, p) for p in trailheads)
println(p1, " ", p2)
