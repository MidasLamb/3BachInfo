eval(int(I), _ , I).
eval(var(X),[pair(X,V)|_],V).
eval(var(X),[_|Rest],V) :-
    eval(var(X),Rest,V).
eval(plus(X,Y),L,R) :-
    eval(X,L,R1),
    eval(Y,L,R2),
    R is R1 + R2.
eval(times(X,Y),L,R) :-
    eval(X,L,R1),
    eval(Y,L,R2),
    R is R1 * R2.
eval(pow(Y,M),L,R) :-
    eval(M,L,1),
    eval(Y,L,R).
eval(pow(X,P),L,R) :-
    eval(X,L,R1),
    eval(P,L,R2),
    E2 is R2 - 1,
    E2 > 0,
    eval(pow(int(R1),int(E2)),L,R3),
    R is R3 * R1.
eval(min(X),L,R) :-
    eval(X,L,R1),
    R is R1 * (-1).