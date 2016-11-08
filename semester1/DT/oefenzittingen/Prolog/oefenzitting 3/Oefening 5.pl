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