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

%% Other solution
% move/3: Moves the head in a certain direction.
move(right,(LL,Head,[LR|LRrest]),([Head|LL],LR,LRrest)).
move(left,([LL|LLrest],Head,LR),(LLrest,LL,[Head|LR])).


% read/2: Reads the symbol under the head.
read_tape((_,Head,_),Head).
    

% write/3: Writes a symbol under the head.
write_tape(Symbol,_,(_,Symbol,_)).
    
