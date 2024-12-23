fname = "inputs/input-23.txt";
lines = Import[StringJoin["/Users/mattpang/projects/aoc2024/", fname],
    "Text"];
splitLines = StringSplit[lines, "\n"];

mynodes[text_] := Module[{out},
  out = StringSplit[text, "-"];
  {out[[1]] \[UndirectedEdge] out[[2]]}]

allnodes = mynodes /@ splitLines;

g = Graph[Flatten[allnodes], VertexLabels -> Automatic];

cycles = FindCycle[g, {3}, All];
containsT[cycle_] := 
  AnyTrue[Flatten[List @@@ cycle], StringStartsQ[#, "t"] &];
(*Filter cycles where at least one node contains "t"*)
cyclesWithT = Select[cycles, containsT];
Print["Part 1":]
Print[Length[cyclesWithT]]
Print["Part 2":]
largestgroup = FindClique[g]
Print[StringRiffle[Sort[largestgroup[[1]]], ","]]