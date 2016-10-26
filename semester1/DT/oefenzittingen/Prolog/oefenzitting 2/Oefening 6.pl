all_primes(X,L) :-
    create_list(X, 2, [], R),
    reverse(R,L).
create_list(Max, Max, List, [Max|List]) :-
    \+ deelbaarDoor(Max, List).
create_list(Max, Max, List, List) :-
    deelbaarDoor(Max, List).
create_list(Max, Count, List, Result) :-
    Count < Max,
    \+ deelbaarDoor(Count, List),
    CountNew is Count + 1,
    create_list(Max, CountNew, [Count|List], Result).
create_list(Max, Count, List, Result) :-
    Count < Max,
    deelbaarDoor(Count, List),
    CountNew is Count + 1,
	create_list(Max, CountNew, List, Result).
deelbaarDoor(Getal, [Deler1|_]) :-
    0 is mod(Getal,Deler1).
deelbaarDoor(Getal, [Deler1|OverigeDelers]) :-
    \+ 0 is mod(Getal,Deler1),
    deelbaarDoor(Getal,OverigeDelers).