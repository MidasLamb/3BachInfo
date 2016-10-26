%!esystant


% Example knowledge base
highway(1,2,c).
highway(2,3,a).
highway(1,3,b).
highway(3,5,a).
highway(3,4,c).
highway(5,4,d).

% Deel 2
tour(T) :-
	findall(X, trip(X), List),
	sort(List, [T|_]).

trip(T) :-
	findall(highway(1,Y,C),highway(1,Y,C), StartPositions),
	member(highway(1,L,Color), StartPositions),
	getNodes(Nodes),
	max_member(X, Nodes),
	Length is X + 1,
	findNext(L-Color, Length, [], T),
	length(T, Length).

findNext(LastNode-LastColor, Length, ListTrip, FinalList) :-
	length(ListTrip, LL),
	LL =< Length -2,
	findall(Node-Color,((highway(Node,LastNode,Color);highway(LastNode,Node,Color)), Color \== LastColor), NextPositions),
	member(NewNode-NewColor, NextPositions),
	(NewNode == 1 ->
		
			reverse([NewNode-NewColor, LastNode-LastColor|ListTrip], FinalList)
		;
		
			findNext(NewNode-NewColor, Length, [LastNode-LastColor|ListTrip], FinalList)
		).
			

% Deel 1
check :-
	getNodes([Node|Rest]),
	%Eerste voorwaarde
	checkEven([Node|Rest]),
	%Tweede voorwaarde
	checkColors(Rest).

checkColors([_|[]]):- !.

checkColors([Node|Rest]):-
	checkColor(Node),
	checkColors(Rest).

checkColor(Node):-
	getAllColors(Node, Colors),
	countColors(Colors, CountL),
	colorsMatch(CountL, []).

colorsMatch([],_):- !.

colorsMatch([First|Rest], List2) :-
	sumlist(Rest, S1),
	sumlist(List2, S2),
	Sum is S1 + S2,
	First =< Sum,
	colorsMatch(Rest, [First|List2]).

sumlist(List, Result):-
	sumlist(List, 0, Result).

sumlist([],C,C).
sumlist([H|T],Acc,R) :-
    NewAcc is Acc + H,
	sumlist(T, NewAcc, R).

countColors([], []):- !.

countColors([Color|Rest], CountList):-
	length(Rest, L1),
	delete(Rest, Color, NL),
	length(NL, L2),
	AmountColor is L1 - L2 + 1,
	countColors(NL, Result),
	CountList = [AmountColor|Result].
	
	
getAllColors(Node, Colors):-
	findall(C, (highway(Node,_,C);highway(_,Node,C)), Colors).

checkEven([]):- !.

checkEven([Node|Rest]):-
	hasEvenEdges(Node),
	checkEven(Rest).

hasEvenEdges(Node):-
	findall(Y, (highway(Node,Y,_);highway(Y,Node,_)), AllConn),
	length(AllConn, Length),
	Length mod 2 =:= 0.
	
    
getNodes(Nodes):-
    findall(X, (highway(X,_,_);highway(_,X,_)), List),
    list_to_set(List, Nodes).


