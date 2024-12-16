use strict;
use warnings;
use List::Util qw(min);

# Read the maze from the file
my $filename = './inputs/input-16.txt';

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
my @maze = <$fh>;
close $fh;

# Remove trailing newlines from each line
chomp @maze;

# Directions: [dx, dy]
my @directions = (
    [0, 1],   # East
    [1, 0],   # South
    [0, -1],  # West
    [-1, 0],  # North
);

# Find the start and end positions
my ($start_x, $start_y, $end_x, $end_y);
for my $x (0 .. $#maze) {
    for my $y (0 .. length($maze[$x]) - 1) {
        $start_x = $x, $start_y = $y if substr($maze[$x], $y, 1) eq 'S';
        $end_x = $x, $end_y = $y if substr($maze[$x], $y, 1) eq 'E';
    }
}

# BFS setup
my @queue = ([$start_x, $start_y, 0, 0, []]); # [x, y, direction, cost, path]
my %visited;    # To track visited states with the minimum cost
my @valid_paths; # To store all valid paths with the minimum cost
my $min_cost = undef; # Minimum cost to the endpoint

# BFS Loop
while (@queue) {
    my ($x, $y, $dir, $cost, $path) = @{shift @queue};
    my @current_path = (@$path, [$x, $y]);

    # If we reached the end
    if ($x == $end_x && $y == $end_y) {
        # Update minimum cost and valid paths
        if (!defined $min_cost || $cost < $min_cost) {
            $min_cost = $cost;
            @valid_paths = (\@current_path);
        } elsif ($cost == $min_cost) {
            push @valid_paths, \@current_path;
        }
        next;
    }

    # Skip if already visited with a lower cost. 
    # very important its < and not equal for part2
    next if exists $visited{"$x,$y,$dir"} && $visited{"$x,$y,$dir"} < $cost;
    $visited{"$x,$y,$dir"} = $cost;

    # Move forward
    my ($dx, $dy) = @{$directions[$dir]};
    my ($nx, $ny) = ($x + $dx, $y + $dy);
    if ($nx >= 0 && $nx <= $#maze && $ny >= 0 && $ny < length($maze[$nx]) &&
        substr($maze[$nx], $ny, 1) ne '#') {
        push @queue, [$nx, $ny, $dir, $cost + 1, \@current_path];
    }

    # Rotate clockwise
    my $cw_dir = ($dir + 1) % 4;
    push @queue, [$x, $y, $cw_dir, $cost + 1000, \@current_path];

    # Rotate counterclockwise
    my $ccw_dir = ($dir - 1) % 4;
    $ccw_dir += 4 if $ccw_dir < 0; # Handle negative modulo
    push @queue, [$x, $y, $ccw_dir, $cost + 1000, \@current_path];
}

# Analyze valid paths
if (defined $min_cost) {
    print "Minimum cost: $min_cost\n";

    my %point_count;
    for my $path (@valid_paths) {
        for my $point (@$path) {
            my $key = join(",", @$point); # Create a unique key for the point as "x,y"
            $point_count{$key}++;         # Increment count for this point
        }
    }

    my $unique_points = keys %point_count;
    print "Total unique points involved in all valid paths: $unique_points\n";
} else {
    print "No path to the endpoint was found.\n";
}