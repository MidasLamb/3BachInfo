%!esystant

translate(List, Result) :-
    translate(List, [], Result).

translate([], _, []):- !.

translate([def(X)|Rest], SL, Result):-
    symbolListGet(X, SL, R),
    symbolStore(X-R, SL, NL),
    translate(Rest, NL, Result2),
    Result = [asgn(X, R)|Result2].

translate([use(X)|Rest], SL, Result):-
    symbolListSearch(X, SL, R),
    (R == null) ->
    	( 
    		symbolStore(X-V, SL, NL)
    	); 
    	(
    		NL = SL,
    		V = R
    	),
    translate(Rest, NL, Result2),
    Result = [use(V)|Result2].

symbolStore(X-R, SL, DNL):-
    reverse([X-R|SL], NL),
    list_to_set(NL, DNL).

symbolListSearch(_, [], null):- !.

symbolListSearch(K, [K-V|_], V):- !.

symbolListSearch(S, [_|X], R):-
    symbolListSearch(S, X, R).

symbolListGet(_, [], 1):- !.

symbolListGet(K, [K-V|_], V):- !.

symbolListGet(K, [_-V|K-var(Y)|_], Y):-
    Y is V + 1.

symbolListGet(_, [_-V|[]], R):-
    R is V + 1,
    !.

symbolListGet(S, [_|X], R):-
    symbolListGet(S, X, R).