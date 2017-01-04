balanced(T):-
    balanced(T,_).
balanced(empty, 0).
balanced(node(A,_,B),Y) :-
    balanced(A,L1),
    balanced(B,L2),
    (	(L1 is L2 + 1, Y is L1 + 1);
    	(L2 is L1 + 1, Y is L2 + 1);
    	(L1 is L2, Y is L1 +1)
    ).
    
add_to(empty,X,node(empty,X,empty).
add_to(node(empty,Y,Z),X,node(node(empty,X,empty),Y,Z)).
add_to(node(Z,Y,empty),X,node(Z,Y,node(empty,X,empty))).
add_to(node(A,C,B),X,R) :-
    (   
    	(add_to(A,X,Tree), balanced(node(Tree,C,B)), R = node(Tree,C,B));
    	(add_to(B,X,Tree), balanced(node(A,C,Tree)), R = node(A,C,Tree))
    ).
