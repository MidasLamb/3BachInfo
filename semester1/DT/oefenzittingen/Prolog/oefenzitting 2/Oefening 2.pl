node(a).
node(b).
node(c).
node(d).
node(e).
edge(a,b).
edge(b,c).
edge(b,d).
edge(c,d).

neighbor(X,Y):-
    edge(X,Y);
    edge(Y,X).

path(X,Y):-
    neighbor(X,Y).

path(X,Y):-
    path(X,Z),
    path(Z,Y).

path2(X,Y):-
    path2(X,Y,[]).

path2(X,Y,L):-
    neighbor(X,Y),
    \+ member(Y,L).

path2(X,Y,L):- 
    neighbor(X,Z),
    \+ member(Z,L),
    path2(Z,Y,[X,Z|L]).
