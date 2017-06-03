translate(List, Result):-
    translate(List, [], 0, Result).

translate([], _ST, _Count, []):- !.

translate([def(K)|RL], ST, Count, Result):-
    NewCount is Count + 1,
    symbolTableUpdate(pair(K,NewCount), ST, NST),
    translate(RL, NST, NewCount, RR),
    Result = [asgn(K, NewCount)|RR].

translate([use(K)|RL], ST, Count, Result):-
    symbolTableUpdate(pair(K,V), ST, NST),
    translate(RL, NST, Count, RR),
    Result = [use(V)|RR].
    
% The clue of the symbol table is that when you encounter a use(X), you add a pair(X,V), in which V is a free variable for the moment.
% When you then encounter a def(X), you will fill in the symbol table for pair(X,V) and unify the V with the counter on that moment.

symbolTableUpdate(NV, ST, ST):-
    symbolTableUpdateV(NV, ST, updated),
    !.
    
symbolTableUpdate(NV, ST, [NV|ST]):- !.


symbolTableUpdateV(_, [], null):- !.

symbolTableUpdateV(pair(K,V), [pair(K,V)|_], updated):- !.

symbolTableUpdateV(NV, [_|Rest], Result):-
    symbolTableUpdateV(NV, Rest, Result).
    
    
%% Cheeky breeky method:
%Deze translate is niet de bedoeling: het maakt gebruik van 1 pass-trough, maar het vult de symbooltabel in op de weg naar beneden, en negeert de "use", om dan op de weg naar bove deze in te vullen.
translate(L,R):- htranslate(L,[],_,1,R).

htranslate([],H,H,_,[]).
htranslate([def(A)|Re],H,Acc, C, [asgn(A,C)|R]):-
        C1 is C + 1,
        htranslate(Re,[pair(A,C)|H],Acc, C1, R).
        
htranslate([use(A)|Re],H,Acc, C,[use(N)|R]):-
        htranslate(Re,H,Acc,C,R),  %Dat dit geen staartrecursie is, zorgt ervoor dat deze methode werkt.
        findN(A, Acc,N).
        
findN(A,[pair(A,N)|_], N):- !.
findN(A,[_|R], N):- findN(A,R,N).
    
%% SOLUTION A LA JONAH BELLEMANS:

%!esystant

translate(List, Output) :-
    translate(List, [], 0, Output).
    
translate([], _, _, []).

translate([def(X) | RestInp], PrevST, PrevCount, Output) :-
    member(pair(X, N), PrevST) -> 
    (
    Count is PrevCount + 1,
    N = Count,
    translate(RestInp, PrevST, Count, RestOutp),
    Output = [asgn(X, Count) | RestOutp]
    );
    (
    Count is PrevCount + 1,
    ST = [pair(X, Count) | PrevST],
    translate(RestInp, ST, Count, RestOutp),
    Output = [asgn(X, Count) | RestOutp]
    ).
    
translate([use(X) | RestInp], ST, Count, Output) :-
    member(pair(X, Y), ST) -> 
    (
    translate(RestInp, ST, Count, RestOutp),
    Output = [use(Y) | RestOutp]
    ) ;
    (
    NewST = [pair(X, Num) | ST], 
    translate(RestInp, NewST, Count, RestOutp),
    Output = [use(Num) | RestOutp]
    ).
