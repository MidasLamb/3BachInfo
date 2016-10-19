%!esystant

% The mini-meta-interpreter without memoization.
interpret((G1,G2)) :- !,
    interpret(G1),
    interpret(G2).

interpret(true) :- !.

interpret(X > Y) :- !,
    X > Y.

interpret(X is Y) :- !,
    X is Y.

interpret(Head) :-
    clause(Head,Body),
    interpret(Body).

% The mini-meta-interpreter without memoization for built-ins.
interpret_mem(Query) :-
	interpret_mem(Query,[],_).

interpret_mem((G1,G2),Mem,MemOut) :- !, 
    interpret_mem(G1,Mem,Mem1), 
    interpret_mem(G2,Mem1,MemOut).

interpret_mem(true,Mem,Mem) :- !.

interpret_mem(Head,Mem,MemOut) :- 
	( member(Head,Mem) ->
		MemOut = Mem
	;
		clause(Head,Body), 
		interpret_mem(Body,Mem,Mem1),
		MemOut = [Head|Mem1]
	).

% The mini-meta-interpreter with memoization for built-ins.
interpret_mem2(Query) :-
	interpret_mem2(Query,[],_).

interpret_mem2((G1,G2),Mem,MemOut) :- !, 
    interpret_mem2(G1,Mem,Mem1), 
    interpret_mem2(G2,Mem1,MemOut).

interpret_mem2(true,Mem,Mem) :- !.

interpret_mem2(X > Y,Mem,MemOut) :- !,
    X > Y,
    MemOut = [X > Y| Mem].

interpret_mem2(X is Y,Mem,MemOut) :- !,
    X is Y,
    MemOut = [X is Y| Mem].
    
interpret_mem2(Head,Mem,MemOut) :- 
	( member(Head,Mem) ->
		MemOut = Mem
	;
		clause(Head,Body), 
		interpret_mem2(Body,Mem,Mem1),
		MemOut = [Head|Mem1]
	).

% fib/2
fib(0,1).
fib(1,1).
fib(N,F) :-
    N > 1,
    N2 is N - 2,
    fib(N2,F2),
    N1 is N - 1,
    fib(N1,F1),
    F is F1 + F2.