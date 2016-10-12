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
% Betere methode zou zijn door de lijst op te stellen tot het benodigde nummer
