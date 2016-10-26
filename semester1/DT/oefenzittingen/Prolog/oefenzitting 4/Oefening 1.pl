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
    
symbolTableUpdate(NV, ST, ST):-
    symbolTableUpdateV(NV, ST, updated),
    !.
    
symbolTableUpdate(NV, ST, [NV|ST]):- !.


symbolTableUpdateV(_, [], null):- !.

symbolTableUpdateV(pair(K,V), [pair(K,V)|_], updated):- !.

symbolTableUpdateV(NV, [_|Rest], Result):-
    symbolTableUpdateV(NV, Rest, Result).
    
    
