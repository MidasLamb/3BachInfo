%!esystant

% move/3: Moves the head in a certain direction.
move(left,pair(C,pair([L|Rest],R)),pair(L,pair(Rest,[C|R]))) :-
    (   var(L) ->
    	(
        	L = #,
             Rest = [#]
		); 
    	true
    ),
    (   var(R) ->  
    	(   
    		R = [#]
    	); 
    	true
    ).

move(right,pair(C,pair(L,[R|Rest])),pair(R,pair([C|L], Rest))).

% read/2: Reads the symbol under the head.
read_tape(pair(C,_),C).

% write/3: Writes a symbol under the head.
write_tape(C,pair(_,R),pair(C,R)).

%% Other solution which exists out of representing the tape as 1 pair of lists, where the first element of the "right" list represents the element under the head:
% move/3: Moves the head in a certain direction.
move(right,pair([L|Lr],[R|Rr]),pair([R,L|Lr],[Rr])).

    
move(left,pair([L|Lr],[R|Rr]),pair([Lr],[L,R|Rr])).

% read/2: Reads the symbol under the head.
read_tape(pair([_],[R|_],R)).

% write/3: Writes a symbol under the head.
write_tape(S,pair([_],[_|_]),pair([_],[S|_])).