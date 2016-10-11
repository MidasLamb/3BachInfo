father(anton,bart).
father(anton,daan).
father(anton,elisa).
father(fabian,anton).

mother(celine,bart).
mother(celine,daan).
mother(celine,gerda).
mother(gerda,hendrik).

/* X \== Y: kan X een andere waarde krijgen dan Y? */
sibling(X,Y) :- 
    father(F,X),
    father(F,Y),
    mother(M,X),
    mother(M,Y),
    X \== Y.
    
ancestor(X,Y) :- father(X,Y).

ancestor(X,Y) :-
    father(Z,Y),
    ancestor(X,Z).
    

peano_plus(zero,X,X).

peano_plus(s(X),Y,s(Z)) :- peano_plus(X,Y,Z).

min(X,zero,X).

min(s(X),s(Y),Z) :- min(X,Y,Z).

greater_than(s(_),zero).
greater_than(s(X),s(Y)) :- greater_than(X,Y).

maximum(X,X,X).
maximum(X,Y,X) :- greater_than(X,Y).
maximum(X,Y,Y) :- greater_than(Y,X).

depth(nil, 0).
depth(node(L,_,R),D) :- 
    depth(L,A),
    depth(R,B),
    D is max(A,B) + 1.
    

eval(tru, tru).

eval(fal, fal).

eval(and(B1,B2),tru) :- 
    eval(B1,tru),
    eval(B2,tru).
    
eval(and(B1,_),fal) :-
    eval(B1,fal).
    
eval(and(_,B2),fal) :-
    eval(B2,fal).
    
eval(or(B1,_),tru) :-
    eval(B1,tru).
    
eval(or(_,B2),tru) :-
    eval(B2,tru).
    
eval(or(B1,B2),fal) :-
    eval(B1,fal),
    eval(B2,fal).
    
eval(not(B),tru) :-
    eval(B,fal).
    
eval(not(B),fal) :-
    eval(B,tru).
    
    
eval(number(X),X).

eval(plus(B1,B2),X) :-
    eval(B1,Y),
    eval(B2,Z),
    X is Y+Z.
    
eval(min(B1,B2),X) :-
    eval(B1,Y),
    eval(B2,Z),
    X is Y-Z.
    
eval(neg(B),X) :-
    eval(B,Y),
    X is -Y.
    
eval(=(B1,B2),tru) :-
    eval(B1,Y),
    eval(B2,Y).

eval(=(B1,B2),fal) :-
    eval(B1,Y),
    not(eval(B2,Y)).
    

minmaxtree(T,R) :- 
    mintree(T,R).

mintree(leaf(X),X).

mintree(node(C1-LTree, C2-_),R) :-
    not(C1 > C2),
    maxtree(LTree,R).
    
mintree(node(C1-_, C2-RTree),R) :-
    C1 > C2,
    maxtree(RTree,R).

maxtree(leaf(X),X).

maxtree(node(C1-LTree, C2-_),R) :-
    not(C1 < C2),
    mintree(LTree,R).
    
maxtree(node(C1-_, C2-RTree),R) :-
    C1 < C2,
    mintree(RTree,R).
    