%!esystant

increment(X,Y) :- Y is X + 1.

decrement(X,Y) :- Y is X - 1.

map(_,[],[]).
    

map(P,[F|Xs],[R|Ys]) :-
    Function =.. [P, F, R],
    call(Function),
    map(P,Xs,Ys).