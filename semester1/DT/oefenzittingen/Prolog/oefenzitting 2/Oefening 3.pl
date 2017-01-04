fib(1, 0).
fib(2,1).
fib(Position,Result) :-
    Pos1 is Position - 1,
    fib(Pos1, R1),
    Pos2 is Pos1 - 1,
    fib(Pos2, R2),
    Result is R1 + R2.
% Slechte implementatie omdat cijfers altijd dubbel worden berekend,
% bijvoorbeeld positie 6 wordt berekend als de som van positie 4 en 5
% voor positie 4 wordt de som berekend van 2 en 3
% voor positie 5 wordt de som berekend van 3 en 4
% Het cijfer dat op positie 3 staat wordt dus meer dan 2 keer berekend, ook positie 4 wordt opnieuw berekend, 
% 	terwijl we deze al weten.
% 
% time(fib(25,R)). : 
%   300,097 inferences, 1.476 CPU in 1.476 seconds (100% CPU, 203329 Lips)

% Betere methode is door een lijst op te stellen tot het benodigde nummer:
% 
% time(fib2(50000,R)). : 
%   99,999 inferences, 0.300 CPU in 0.300 seconds (100% CPU, 333319 Lips)
fib2(X,Y) :- fib2(X,Y,[1,0]).

fib2(1,0,_):- !.
fib2(2,Y,[Y|_]):- !.
fib2(X,Y,[A,B|Rest]) :-
    X1 is X - 1,
    R1 is A + B,
    fib2(X1,Y,[R1,A,B|Rest]).

% Bottom-up implementatie (bron: "Prolog programming for artificial intelligence", Ivan Bratko, 1e editie - p. 196)
% 
% time(fib3(50000,R)). : 
%   199,995 inferences, 0.198 CPU in 0.198 seconds (100% CPU, 1010524 Lips)
fib3(1,0).
fib3(N,R) :-
    forwardfib(2,N,0,1,R).

forwardfib(M,N,_,F2,F2) :-
    M >= N.

forwardfib(M,N,F1,F2,F) :-
    M < N,
    MM is M + 1,
    FF is F1 + F2,
    forwardfib(MM,N,F2,FF,F).
