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