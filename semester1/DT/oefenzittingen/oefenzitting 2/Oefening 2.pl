edge(node(a),node(b)).
edge(node(b), node(d)).
edge(node(b), node(c)).

node(a).
node(b).
node(c).
node(d).
node(e).

neighbor(X,Y) :-
    edge(node(X),node(Y)).
neighbor(X,Y) :-
    edge(node(Y), node(X)).

% Versie 1
path(X,Y) :-
    neighbor(X,Y).
path(X,Y) :-
    neighbor(X,Z),
    path(Z,Y).

% Versie 2
path2(X,Y) :-
    path2(X,Y,[]).

path2(X,Y,_) :-
    neighbor(X,Y),
	X \= Y.

path2(X,Y,L) :-
    neighbor(X,Z),
    \+ member(Z,L),
    path2(Z,Y,[Z|L]),
    X \= Y,
    Y \= Z,
    X \= Z.