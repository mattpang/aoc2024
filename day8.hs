-- $cabal install --lib containers
-- ghc day8.hs -o ./a.out;
import System.IO
import System.Environment (getArgs)
import Data.List (nub)
import qualified Data.Map as Map

type Point = (Int, Int)
type Grid = [[Char]]

-- Parse the grid and extract antennas
parseGrid :: Grid -> Map.Map Char [Point]
parseGrid grid = foldl extractAntenna Map.empty coords
  where
    rows = length grid
    cols = length (head grid)
    coords = [(x, y) | x <- [0..rows-1], y <- [0..cols-1]]
    extractAntenna m (x, y) =
      let char = grid !! x !! y
      in if char /= '.'
         then Map.insertWith (++) char [(x, y)] m
         else m

-- Check if one antenna is twice as far from another
isValidAntinode :: Point -> Point -> Point -> Maybe Point
isValidAntinode (x1, y1) (x2, y2) (x3, y3) =
  let d1 = (x2 - x1, y2 - y1) -- Vector from p1 to p2
      d2 = (x3 - x1, y3 - y1) -- Vector from p1 to p3
  in if d2 == (2 * fst d1, 2 * snd d1) || d1 == (2 * fst d2, 2 * snd d2)
     then Just (x3, y3)
     else Nothing

-- Generate antinodes for a frequency
generateAntinodes :: [Point] -> [Point]
generateAntinodes points = nub $ concatMap antinodesForPair pairs
  where
    pairs = [(p1, p2) | p1 <- points, p2 <- points, p1 /= p2]
    antinodesForPair (p1, p2) =
      let (x1, y1) = p1
          (x2, y2) = p2
          dx = x2 - x1
          dy = y2 - y1
          antinode1 = (x1 - dx, y1 - dy)
          antinode2 = (x2 + dx, y2 + dy)
      in [antinode1, antinode2]

-- Filter antinodes within the grid bounds
filterBounds :: (Int, Int) -> [Point] -> [Point]
filterBounds (rows, cols) = filter (\(x, y) -> x >= 0 && y >= 0 && x < rows && y < cols)

-- Main function to calculate unique antinodes
countUniqueAntinodes :: Grid -> Int
countUniqueAntinodes grid = length . nub . concat $ allAntinodes
  where
    rows = length grid
    cols = length (head grid)
    antennas = parseGrid grid
    antinodes = Map.map generateAntinodes antennas
    allAntinodes = map (filterBounds (rows, cols)) (Map.elems antinodes)

-- Part 2: Find all positions exactly in line with at least two antennas
part2countUniqueAntinodes :: Grid -> Int
part2countUniqueAntinodes grid = length . nub $ concatMap findAntinodes groupedAntennas
  where
    rows = length grid
    cols = length (head grid)
    antennas = parseGrid grid
    groupedAntennas = Map.elems antennas

    findAntinodes :: [Point] -> [Point]
    findAntinodes points = nub $ concatMap allCollinearPoints pairs
      where
        pairs = [(p1, p2) | p1 <- points, p2 <- points, p1 /= p2]
        allCollinearPoints (p1, p2) =
          let (x1, y1) = p1
              (x2, y2) = p2
              dx = x2 - x1
              dy = y2 - y1
              inLinePoints = [(x1 + i * dx, y1 + i * dy) | i <- [-50..50]] -- Check along line
          in filterBounds (rows, cols) inLinePoints

-- Main function
main :: IO ()
main = do
    args <- getArgs
    case args of
        [filePath] -> do
            content <- readFile filePath
            let grid = lines content
            print $ countUniqueAntinodes grid
            print $ part2countUniqueAntinodes grid
        _ -> putStrLn "Usage: ./a.out <input-file>"