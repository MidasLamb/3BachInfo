%!esystant

% solve/2
% This predicate solves the puzzle with the given puzzle id.
% Example: solve(1,Solution)
solve(PuzzleId,Solution) :-
    puzzle(PuzzleId,Grid,Links),
    arukone(Grid,Links,Solution).

% show_puzzle/1
% This predicate prints the puzzle with the given puzzle id to the standard output.
% Example: show_puzzle(1)
show_puzzle(PuzzleId) :-
    puzzle(PuzzleId,Grid,Links),
    generate_empty_grid(Grid,Array),
    add_links_to_grid(Links,Array),
    show_grid(Array).

% show_solution/1
% This predicate first solves the puzzle with the given puzzle id and then prints the solution to the standard output.
% Example: show_solution(1)
show_solution(PuzzleId) :-
    puzzle(PuzzleId,Grid,_),
    generate_empty_grid(Grid,Array),
    solve(PuzzleId,Solution),
    add_solution_to_grid(Solution,Array),
    show_grid(Array).

% arukone/3
% This predicate solves a puzzle given a grid and a list of links. The general strategy goes as follows:
% 1. Sort the links in a particular order (see sort_links/3).
% 2. Retrieve all occupied positions.
% 3. Find a solution given the links and occupied positions.
arukone(Grid,Links,Solution) :-
    sort_links(Links,Grid,SortedLinks),
    findall(Position,(member(link(_,Position,_),Links) ; member(link(_,_,Position),Links)),UsedPositions), !,
    connect(Grid,SortedLinks,UsedPositions,Solution).

% connect/4
% This predicate iterates through the provided list of links and proceeds two steps in each iteration:
% 1. It finds a valid path for the link.
% 2. It adds the positions the path goes through to the list of occupied positions.
connect(grid(Height,Width),[],UsedPositions,[]) :- 
	list_to_set(UsedPositions,S),
	length(S, L),
	L =:= Height*Width.
	
connect(Grid,[link(N, StartPos, FinalPos)|RestOfSortedLinks],UsedPositions,Solution) :-
	path(Grid, StartPos, FinalPos, UsedPositions, SolutionPositions),
	append(SolutionPositions, UsedPositions, NewUsedPositions),
	connect(Grid, RestOfSortedLinks, NewUsedPositions,NewSolution),
	Solution = [connects(N, SolutionPositions)|NewSolution].


path(_Grid, pos(XS, YS), pos(XF, YF), _, [pos(XS,YS),pos(XF, YF)]) :-
	(
		(
			XS is XF +1 ; 
			XS is XF -1
		),
		YS is YF
	);
	(
		(	YS is YF +1;
			YS is YF -1
		),
		XS is XF
	).

path(Grid, pos(XS, YS), Final, UsedPositions, SolutionPositions) :-
	(XN is XS -1;
		XN is XS +1),
	NewPos = pos(XN, YS),
	is_valid_position(Grid, NewPos),
	\+ member(NewPos, UsedPositions),
	path(Grid, NewPos, Final, [NewPos|UsedPositions], TempSolutionPositions),
	SolutionPositions = [pos(XS, YS)|TempSolutionPositions].

path(Grid, pos(XS, YS), Final, UsedPositions, SolutionPositions) :-
	(YN is YS -1;
		YN is YS +1),
	NewPos = pos(XS, YN),
	is_valid_position(Grid, NewPos),
	\+ member(NewPos, UsedPositions),
	path(Grid, NewPos, Final, [NewPos|UsedPositions], TempSolutionPositions),
	SolutionPositions = [pos(XS, YS)|TempSolutionPositions].
    

% is_valid_position/2
% This predicate verifies whether a given position is valid.
is_valid_position(grid(Height,Width),pos(Row,Column)) :-
    between(1,Height,Row),
    between(1,Width,Column).

% is_valid_edge/3
% This predicate verifies whether a given edge, which is represented by its start and end location, is valid.
is_valid_edge(Grid,pos(Row1,Column),pos(Row2,Column)) :-
    is_valid_position(Grid,pos(Row1,Column)),
    is_valid_position(Grid,pos(Row2,Column)),
    abs(Row1 - Row2) =:= 1.
is_valid_edge(Grid,pos(Row,Column1),pos(Row,Column2)) :-
    is_valid_position(Grid,pos(Row,Column1)),
    is_valid_position(Grid,pos(Row,Column2)),
    abs(Column1 - Column2) =:= 1.

% sort_links/3
% This predicate sorts the given links according to a particular heuristic. This template provides four different heuristics.
% 1. Long links: puts the longest links first 
% 2. Short links: puts the shortest links first
% 3. Links on edges: puts the links closest to the edge first
% 4. Combination: combines (1) and (3)
% Consult the SWI-Prolog manual for further details on the predsort/3 predicate.
sort_links(Links,Grid,SortedLinks) :-
    predsort(long_links_first,Links,SortedLinks).
    % predsort(short_links_first,Links,SortedLinks).
    % predsort(edges_first(Grid),Links,SortedLinks).
    % predsort(combination_first(Grid),Links,SortedLinks).

% compute_distance/3
% This predicate computes the distance between two positions.
compute_distance(pos(Row1,Column1),pos(Row2,Column2),Distance) :-
    Distance is sqrt((Row1-Row2)**2 + (Column1-Column2)**2).

% long_links_first/3
long_links_first(<,link(_,PositionA1,PositionA2),link(_,PositionB1,PositionB2)) :-
    compute_distance(PositionA1,PositionA2,DistanceA),
    compute_distance(PositionB1,PositionB2,DistanceB),
    DistanceA >= DistanceB.
long_links_first(>,link(_,PositionA1,PositionA2),link(_,PositionB1,PositionB2)) :-
    compute_distance(PositionA1,PositionA2,DistanceA),
    compute_distance(PositionB1,PositionB2,DistanceB),
    DistanceA < DistanceB.

% short_links_first/3
short_links_first(<,link(_,PositionA1,PositionA2),link(_,PositionB1,PositionB2)) :-
    compute_distance(PositionA1,PositionA2,DistanceA),
    compute_distance(PositionB1,PositionB2,DistanceB),
    DistanceA =< DistanceB.
short_links_first(>,link(_,PositionA1,PositionA2),link(_,PositionB1,PositionB2)) :-
    compute_distance(PositionA1,PositionA2,DistanceA),
    compute_distance(PositionB1,PositionB2,DistanceB),
    DistanceA > DistanceB.

% is_on_edge_of_grid/2
is_on_edge_of_grid(_,pos(1,_)).
is_on_edge_of_grid(_,pos(_,1)).
is_on_edge_of_grid(grid(Height,_),pos(Height,_)).
is_on_edge_of_grid(grid(_,Width),pos(_,Width)).

% on_edge_score/3
on_edge_score(link(_,PositionA1,PositionA2),Grid,Score) :-
    include(is_on_edge_of_grid(Grid),[PositionA1,PositionA2],List),
    length(List,Score).

% edges_first/4
edges_first(Grid,<,Position1,Position2) :-
    on_edge_score(Position1,Grid,Score1),
    on_edge_score(Position2,Grid,Score2),
    Score1 >= Score2.
edges_first(Grid,>,Position1,Position2) :-
    on_edge_score(Position1,Grid,Score1),
    on_edge_score(Position2,Grid,Score2),
    Score1 < Score2.

% combination_first/4
combination_first(Grid,<,Position1,Position2) :-
    on_edge_score(Position1,Grid,Score1),
    on_edge_score(Position2,Grid,Score2),
    Score1 > Score2.
combination_first(Grid,<,Position1,Position2) :-
    on_edge_score(Position1,Grid,Score1),
    on_edge_score(Position2,Grid,Score2),
    Score1 =:= Score2,
    long_links_first(<,Position1,Position2).
combination_first(Grid,>,Position1,Position2) :-
    on_edge_score(Position1,Grid,Score1),
    on_edge_score(Position2,Grid,Score2),
    Score1 < Score2.
combination_first(Grid,>,Position1,Position2) :-
    on_edge_score(Position1,Grid,Score1),
    on_edge_score(Position2,Grid,Score2),
    Score1 =:= Score2,
    long_links_first(>,Position1,Position2).


% Representation of puzzles:
% puzzle(PuzzleId,grid(NbOfRows,NbOfColumns),[link(Label,pos(Row1,Col1),pos(Row2,Col2)),...])

% 1 -- 5x5 easy
% Source: http://www.menneske.no/arukone/eng/
puzzle(1,grid(5,5),[
    link(1,pos(2,1),pos(4,4)),
    link(2,pos(1,1),pos(2,2)),
    link(3,pos(2,4),pos(5,4)),
    link(4,pos(4,2),pos(2,5))
]).

% 2 -- 5x5 very hard
% Source: http://www.menneske.no/arukone/eng/
puzzle(2,grid(5,5),[
    link(1,pos(5,1),pos(5,4)),
    link(2,pos(2,4),pos(5,5)),
    link(3,pos(2,2),pos(1,4))
]).

% 3 -- 6x6
% Source: Flow Free
puzzle(3,grid(6,6),[
    link(1,pos(1,3),pos(3,1)),
    link(2,pos(2,2),pos(5,5)),
    link(3,pos(2,3),pos(3,6)),
    link(4,pos(2,5),pos(5,1)),
    link(5,pos(5,2),pos(6,1))
]).

% 4 -- 7x7 level 30
% Source: Flow Free
puzzle(4,grid(7,7),[
    link(1,pos(1,1),pos(5,1)),
    link(2,pos(1,3),pos(1,5)),
    link(3,pos(1,6),pos(4,7)),
    link(4,pos(2,1),pos(5,3)),
    link(5,pos(2,3),pos(3,5)),
    link(6,pos(2,6),pos(4,5)),
    link(7,pos(5,2),pos(6,6))
]).

% 5 -- 7x7 level 1
% Source: Flow Free
puzzle(5,grid(7,7),[
    link(1,pos(1,7),pos(7,6)),
    link(2,pos(2,6),pos(3,2)),
    link(3,pos(2,7),pos(6,5)),
    link(4,pos(4,4),pos(5,3)),
    link(5,pos(4,5),pos(7,7)),
    link(6,pos(5,5),pos(6,6))
]).

% 6 -- 7x7 level 4
% Source: Flow Free
puzzle(6,grid(7,7),[
    link(1,pos(2,1),pos(7,1)),
    link(2,pos(3,3),pos(4,5)),
    link(3,pos(5,3),pos(6,5)),
    link(4,pos(5,5),pos(6,2)),
    link(5,pos(6,1),pos(6,6))
]).

% 7 -- 7x7 level 27
% Source: Flow Free
puzzle(7,grid(7,7),[
    link(1,pos(1,4),pos(7,7)),
    link(2,pos(1,5),pos(4,2)),
    link(3,pos(2,5),pos(3,3)),
    link(4,pos(2,6),pos(5,6)),
    link(5,pos(3,2),pos(4,4))
]).

% 8 -- 7x7 level 4
% Source: Flow Free
puzzle(8,grid(7,7),[
    link(1,pos(2,1),pos(3,2)),
    link(2,pos(2,2),pos(2,6)),
    link(3,pos(3,1),pos(5,3)),
    link(4,pos(4,2),pos(4,4)),
    link(5,pos(5,2),pos(5,6))
]).

% 9 -- 8x8 level 30
% Source: Flow Free
puzzle(9,grid(8,8),[
    link(1,pos(1,5),pos(1,7)),
    link(2,pos(1,6),pos(4,6)),
    link(3,pos(2,5),pos(7,4)),
    link(4,pos(2,7),pos(4,7)),
    link(5,pos(3,3),pos(5,3)),
    link(6,pos(5,4),pos(7,2)),
    link(7,pos(6,6),pos(7,3))
]).

% 10 -- 8x8 level 4
% Source: Flow Free
puzzle(10,grid(8,8),[
    link(1,pos(1,1),pos(7,8)),
    link(2,pos(2,7),pos(4,7)),
    link(3,pos(2,8),pos(4,2)),
    link(4,pos(3,4),pos(4,8)),
    link(5,pos(5,5),pos(7,3)),
    link(6,pos(5,8),pos(6,3)),
    link(7,pos(6,8),pos(7,4))
]).

% 11 -- 9x9 super easy
puzzle(11,grid(9,9),[
    link(1,pos(8,6),pos(5,8)),
    link(2,pos(2,8),pos(9,9)),
    link(3,pos(8,2),pos(3,5)),
    link(4,pos(1,5),pos(8,7)),
    link(5,pos(6,2),pos(2,3)),
    link(6,pos(1,8),pos(3,9)),
    link(7,pos(3,1),pos(2,2)),
    link(8,pos(4,3),pos(7,4)),
    link(9,pos(2,1),pos(9,4))
]).


% Visualization of puzzles and solutions

% generate_empty_grid/2
generate_empty_grid(grid(Height,Width),Array) :-
    length(Array,Height),
    maplist(length_reverse(Width),Array).

% length_reverse/2
length_reverse(Length,List) :-
    length(List,Length).

% add_links_to_grid/2
add_links_to_grid([],_).
add_links_to_grid([link(Label,pos(Row1,Column1),pos(Row2,Column2))|RestOfLinks],Rows) :-
    nth1(Row1,Rows,Row1Element),
    nth1(Column1,Row1Element,Label),
    nth1(Row2,Rows,Row2Element),
    nth1(Column2,Row2Element,Label),
    add_links_to_grid(RestOfLinks,Rows).

% add_solution_to_grid/2
add_solution_to_grid([],_).
add_solution_to_grid([connects(_,[])|RestOfSolution],Rows) :-
    add_solution_to_grid(RestOfSolution,Rows).
add_solution_to_grid([connects(Label,[pos(Row,Column)|RestOfPath])|RestOfSolution],Rows) :-
    nth1(Row,Rows,RowElement),
    nth1(Column,RowElement,Label),
    add_solution_to_grid([connects(Label,RestOfPath)|RestOfSolution],Rows).

% show_cell/1
show_cell(Cell) :-
    ( var(Cell) -> 
        write(' _')
    ;
        writef(' %w',[Cell])
    ).

% show_row/1
show_row(Row) :-
    maplist(show_cell,Row),
    nl.

% show_grid/1
show_grid(Rows) :-
    nl,
    maplist(show_row,Rows),
    nl.


