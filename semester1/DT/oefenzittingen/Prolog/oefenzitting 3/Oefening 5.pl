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
