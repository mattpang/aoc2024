// rustc day18.rs
// looks like stanard A* algo.
// rustc -o a.out day18.rs; ./a.out

use std::collections::{ HashSet};
use std::cmp::Ordering;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

type Point = (i32, i32);

#[derive(Eq, PartialEq)]
struct Node {
    position: Point,
    cost: i32,
    priority: i32,
}

impl Ord for Node {
    fn cmp(&self, other: &Self) -> Ordering {
        other.priority.cmp(&self.priority)
    }
}

impl PartialOrd for Node {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

fn read_walls(filename: &str, limit: &i32) -> io::Result<HashSet<Point>> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = io::BufReader::new(file);

    let mut walls = HashSet::new();
    let mut i =0;
    for line in reader.lines() {
        let line = line?;
        let coords: Vec<i32> = line
            .split(',')
            .map(|s| s.trim().parse().expect("Invalid number in file"))
            .collect();
        if coords.len() == 2 {
            walls.insert((coords[0], coords[1]));
        }
        
        i+=1;
        if i>=*limit {
            break
        }
    }
    Ok(walls)
}

fn heuristic(a: Point, b: Point) -> i32 {
    (a.0 - b.0).abs() + (a.1 - b.1).abs()
}

fn neighbors(point: Point, max_x: i32, max_y: i32) -> Vec<Point> {
    let mut result = Vec::new();
    let (x, y) = point;

    for &(dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
        let nx = x + dx;
        let ny = y + dy;
        if nx >= 0 && ny >= 0 && nx <= max_x && ny <= max_y {
            result.push((nx, ny));
        }
    }
    result
}

fn a_star(
    start: Point,
    goal: Point,
    walls: &HashSet<Point>,
    max_x: i32,
    max_y: i32,
) -> Option<(Vec<Point>, usize)> {
    use std::collections::{BinaryHeap, HashMap};

    let mut open_set = BinaryHeap::new();
    let mut came_from: HashMap<Point, Point> = HashMap::new();
    let mut g_score: HashMap<Point, i32> = HashMap::new();
    let mut f_score: HashMap<Point, i32> = HashMap::new();

    g_score.insert(start, 0);
    f_score.insert(start, heuristic(start, goal));

    open_set.push(Node {
        position: start,
        cost: 0,
        priority: heuristic(start, goal),
    });

    while let Some(current_node) = open_set.pop() {
        let current = current_node.position;

        if current == goal {
            // Reconstruct path
            let mut path = Vec::new();
            let mut current = current;
            while let Some(&prev) = came_from.get(&current) {
                path.push(current);
                current = prev;
            }
            path.push(start);
            path.reverse();
            return Some((path.clone(), path.len() - 1));
        }

        for neighbor in neighbors(current, max_x, max_y) {
            if walls.contains(&neighbor) {
                continue; // Skip walls
            }

            let tentative_g_score = g_score.get(&current).unwrap_or(&i32::MAX) + 1;

            if tentative_g_score < *g_score.get(&neighbor).unwrap_or(&i32::MAX) {
                came_from.insert(neighbor, current);
                g_score.insert(neighbor, tentative_g_score);
                f_score.insert(
                    neighbor,
                    tentative_g_score + heuristic(neighbor, goal),
                );

                open_set.push(Node {
                    position: neighbor,
                    cost: tentative_g_score,
                    priority: tentative_g_score + heuristic(neighbor, goal),
                });
            }
        }
    }

    None
}

fn print_walls(walls: &HashSet<Point>, max_x: i32, max_y: i32) {
    for y in 0..=max_y {
        for x in 0..=max_x {
            if walls.contains(&(x, y)) {
                print!("#"); // Wall
            } else {
                print!("."); // Empty space
            }
        }
        println!(); // Newline after each row
    }
}

fn main() -> io::Result<()> {
    
    // let filename = "sample.txt";
    // let limit = 12;
    // let max_x = 6;
    // let max_y = 6;
    
    let filename = "inputs/input-18.txt";
    let limit = 1024;
    let max_x = 70;
    let max_y = 70;

    let walls = read_walls(filename,&limit)?;
    
    
    let start = (0, 0);
    let goal = (max_x, max_y);
    
    print_walls(&walls,max_x,max_y);
    let mut found_steps = 0;
    if let Some((path, steps)) = a_star(start, goal, &walls, max_x, max_y) {
        println!("Path found: {:?}", path);
        println!("Shortest path length: {}", steps);
        found_steps = steps as i32;
    } else {
        println!("No path found.");
    }

    // part 2, find the coords of the wall that blocks first returns no possible path
    for i in (found_steps..=3450).rev(){
        
        let walls = read_walls(filename,&i)?;
        if let Some((_path, _steps)) = a_star(start, goal, &walls, max_x, max_y) {
            print!("Blocking line at {}",i);

            let path = Path::new(filename);
            let file = File::open(&path)?;
            let reader = io::BufReader::new(file);
        
            if let Some(Ok(line)) = reader.lines().nth((i-1) as usize) {
                println!("{:?}", line);
            }                
            break
        } else{
            continue
        }

    }


    Ok(())
}