%!esystant

queens(N,S) :-
    oneSol(N,S), 
    check(N,S).
    
check(_, []) :- !.

check(N, [E|L]) :-
    checkRow(E, 1, N, L),
    check(N, L).

checkRow(_,_,_,[]) :- !.
    
checkRow(H, R, N, [E|L]) :-
    H \= E,
    H + R mod N =\= E,
    E + R mod N =\= H,
    NR is R +1,
    checkRow(H, NR, N, L).	
   
oneSol(N, L) :-
    allNumbers(N,AllN),
    fillList(N, AllN, L).
    
fillList(0, _, []) :- !.
   	
fillList(N, AllN, [E|L]) :-
    member(E,AllN),
    NN is N -1,
    fillList(NN, AllN, L).

allNumbers(0,[]) :- !.

allNumbers(A,[A|L]) :-
   NA is A -1,
   allNumbers(NA, L).
    
    