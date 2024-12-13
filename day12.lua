local function readFile(filename)
    local file = io.open(filename, "r")
    local lines = {}
    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()
    return lines
end

local data = readFile("sample.txt")

-- Create the kaart map
local kaart = {}
for r, line in ipairs(data) do
    for c = 1, #line do
        local char = line:sub(c, c)
        kaart[r .. "," .. c] = char
    end
end

local seen = {}
local dirs = {{1, 0}, {-1, 0}, {0, -1}, {0, 1}}

local function parseCoords(key)
    local r, c = key:match("(%d+),(%d+)")
    return tonumber(r), tonumber(c)
end

local function solve(start)
    local key = kaart[start]
    local queue = {start}
    local perimeter = {}
    local visited = {}

    while #queue > 0 do
        local current = table.remove(queue, 1)
        visited[current] = true
        local r, c = parseCoords(current)

        for _, dir in ipairs(dirs) do
            local dr, dc = dir[1], dir[2]
            local nr, nc = r + dr, c + dc
            local neighbor = nr .. "," .. nc

            if kaart[neighbor] and kaart[neighbor] == key and not visited[neighbor] then
                seen[neighbor] = true
                visited[neighbor] = true
                table.insert(queue, neighbor)
            elseif not visited[neighbor] then
                table.insert(perimeter, {nr, nc, dr, dc})
            end
        end
    end

    return visited, perimeter
end

local function findPerimeter(perimeter)
    local visited = {}
    count = 0

    for _, boundary in ipairs(perimeter) do
        local r, c, ddr, ddc = table.unpack(boundary)
        local boundaryKey = r .. "," .. c .. "," .. ddr .. "," .. ddc
        print(boundaryKey)
        if not visited[boundaryKey] then
            count = count + 1
            local queue = {{r, c}}
            visited[boundaryKey] = 1

            while #queue > 0 do
                local cr, cc = table.unpack(table.remove(queue, 1))
                print(cr,cc,boundaryKey)
                for _, dir in ipairs(dirs) do
                    local dr, dc = dir[1], dir[2]
                    local nr, nc = cr + dr, cc + dc
                    local neighborKey = nr .. "," .. nc .. "," .. ddr .. "," .. ddc

                    if (kaart[neighborKey]) and (not visited[neighborKey]) then
                        table.insert(queue, {nr, nc})
                        visited[neighborKey] = true
                    end
                end
            end
        end
    end

    return count
end

-- Main loop
local p1, p2 = 0, 0

for key, v in pairs(kaart) do
    if not seen[key] then
        local region, perimeter = solve(key)
        local regionSize = 0
        for _ in pairs(region) do
            regionSize = regionSize + 1
        end
        p1 = p1 + regionSize * #perimeter
        -- bug here founding area again not the number of sides
        local fences = findPerimeter(perimeter)
        p2 = p2 + regionSize * fences
        print(v,regionSize,fences)
    end
end

print(p1)
print(p2)