// run with dart day4.dart sample.txt output.txt
// look for xmas
import 'dart:io';
import 'dart:collection';

class Coordinate {
  final int x, y;
  
  Coordinate(this.x, this.y);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Coordinate && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;  // Combining the hashcodes
}

int checker(Coordinate xy,Map grid){
  // check every X in each direction to see if might have an xmas
  // print(grid);
  List ans = [];
  // print(grid[[8,8]]);
  List<String> PAT = 'XMAS'.split(''); 
  // want to iterate PAT and i,j looping (i,j)++/0/--
  //
  int seen = 0;
  for (int xsign in [-1,0,1]){
    for (int ysign in [-1,0,1]){
        List<int> dx = [0*xsign,1*xsign,2*xsign,3*xsign];
        List<int> dy = [0*ysign,1*ysign,2*ysign,3*ysign];

        final cand = [for(int i = 0; i<dx.length; i++) grid[Coordinate(xy.x+dx[i], xy.y+dy[i])]];
        if (cand.join('')=='XMAS'){
          // print((cand,(cand.join('')=='XMAS')));
          seen++;
          [for(int i = 0; i<dx.length; i++) ans.add(Coordinate(xy.x+dx[i], xy.y+dy[i]))];
        }
      }
    }
    
  return seen;
}


String xchecker(Coordinate xy, Map grid){
  // check for x cross of MAS for every A char.

      for (int sign in [-1,1]){

        List<int> dx = [-1,0,1];
        List<int> dy = [-1,0,1];
        String left_cand = [grid[Coordinate(xy.x-1,xy.y-1)],grid[Coordinate(xy.x,xy.y)],grid[Coordinate(xy.x+1,xy.y+1)]].join('');
        String right_cand = [grid[Coordinate(xy.x-1,xy.y+1)],grid[Coordinate(xy.x,xy.y)],grid[Coordinate(xy.x+1,xy.y-1)]].join('');
        // both lside and lright is (MAS or SAM)
        if (((left_cand=='MAS') | (left_cand=='SAM'))&((right_cand=='MAS') | (right_cand=='SAM'))){
          // print([xy.x,xy.y,cand,dx,dy,sign]);
          // print((xy.x,xy.y,left_cand,right_cand));
          return [xy.x,xy.y].join(',');
        }
      }
  return '';
}

void main(List<String> args){
  List<String> input_lines;
  File(args[0]).readAsLines().then((List<String> lines){
    input_lines = lines;
    int y=0;
    Set<String> marked = {};
    // var wgrid = LinkedHashMap<List<int>,String>();
    final wgrid = {};


    for (String line in lines){
      int x =0;
      for (String char in line.split('')){
        //  just make grid first. 
        wgrid[Coordinate(x,y)] = char;
        x++;
      }
      y++;
    }
    
    int total = 0;
    for(Coordinate k in wgrid.keys){
        if (wgrid[k]=='X'){
            int subtotal = checker(k, wgrid);
            total += subtotal;
          };
        }
    print('part 1: $total');

    
    for(Coordinate k in wgrid.keys){
        if (wgrid[k]=='A'){
            String hasseen = xchecker(k, wgrid);
            if (hasseen.length>0){
              marked.add(hasseen);
            }
          };
        }
    print('part 2: ${marked.length}');

    });

     
  }



