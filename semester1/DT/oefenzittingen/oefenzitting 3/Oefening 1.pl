%!esystant


% Knowledge base


teaches(holvoet,bvp).

teaches(moens,bvp).

teaches(demoen,fi).

teaches(dedecker,socs).

teaches(holvoet,swop).

teaches(jacobs,swop).

teaches(demoen,ai).

teaches(deschreye,ai).



takes(joachim,bvp).

takes(joachim,fi).

takes(joachim,ai).

takes(matthias,bvp).

takes(matthias,ai).

takes(thomas,socs).

takes(thomas,swop).

takes(ingmar,swop).


take_same_course(X,Y) :-   
	findall(pair(X,Y), (takes(X,C), takes(Y,C), X \== Y), R),
    list_to_set(R, S),
    member(pair(X,Y), S).

teach_same_course(X,Y) :- 
	findall(pair(T1,T2), (teaches(T1,C), teaches(T2,C), T1 \== T2), R), 
    list_to_set(R, S),
    member(pair(X,Y), S),    
	X \== Y.

teaches_multiple_courses(X) :-
	findall(X, (teaches(X,C1), teaches(X,C2), C1 \== C2), R),
    list_to_set(R, S),
    member(X, S).