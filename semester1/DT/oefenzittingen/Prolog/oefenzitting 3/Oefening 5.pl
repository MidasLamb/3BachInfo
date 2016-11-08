queens(N,PList) :-
    numlist(1,N,List),
    permutation(List,PList),
    validConfiguration(N,PList).
    
    
validConfiguration(N,Configuration) :-
    checkDiagonaal(N,Configuration,1).
    
checkDiagonaal(N,_,Column) :-
    N =< Column , !.
checkDiagonaal(N,[Position|Rest],Column) :-
    N > Column,
    checkDiagonaalForPosition(N,Position,Rest,Column,1),
    ColumnNew is Column + 1,
    checkDiagonaal(N,Rest,ColumnNew).
    
checkDiagonaalForPosition(N,_,_,Column,Offset) :-
    N < Column + Offset, !.
    
checkDiagonaalForPosition(N,Position,[Head|Tail],Column,Offset) :-
    N >= Column + Offset,
    
    PositionUp is Position + Offset,
    PositionDown is Position - Offset,
    
    PositionUp \= Head,
    PositionDown \= Head,
    
    OffsetNew is Offset + 1,
    checkDiagonaalForPosition(N,Position,Tail,Column,OffsetNew).
    
%Other solution
queens(N,L) :-
    numlist(1,N,Lijst),
    permutation(L,Lijst),
    check_diagonal(L).
    
check_diagonal([_|[]]) :- !.
check_diagonal([H1|T]):-
    hulp_check_diagonal(H1,T,1),
        check_diagonal(T).
 
hulp_check_diagonal(_,[],_).
hulp_check_diagonal(H1,[H2|T],G) :-
    \+ (H2 is H1 - G;
        H2 is H1 + G),
        Gnew is G + 1,
        hulp_check_diagonal(H1,T,Gnew).
