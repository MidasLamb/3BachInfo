%!esystant

queens(N,S) :-
    numlist(1, N, List),
    permutation(List, S),
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