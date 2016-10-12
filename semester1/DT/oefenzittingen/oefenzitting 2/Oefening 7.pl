%Niet juist !

alpha_beta(leaf(S,V),_Alpha,_Beta,S,leaf(S,V)).
alpha_beta(max(L,R), Alpha, Beta, Alpha, Newtree) :-
    alpha_beta(L, Alpha, Beta, SL, NewTreeL),
    alpha_beta(R, Alpha, Beta, SR, NewTreeR),
    SL > SR,
    Alpha = SL,
    Newtree = max(NewTreeL, NewTreeR).
alpha_beta(max(L,R), Alpha, Beta, Alpha, Newtree) :-
    alpha_beta(L, Alpha, Beta, SL, NewTreeL),
    SL =< SR,
    NewAlpha = SR,
    alpha_beta(R, NewAlpha, Beta, SR, NewTreeR),
    Newtree = max(NewTreeL, NewTreeR).
alpha_beta(min(L,R), Alpha, Beta, Beta, Newtree) :-
    alpha_beta(L, Alpha, Beta, SL, NewTreeL),
    alpha_beta(R, Alpha, Beta, SR, NewTreeR),
    SL > SR,
    Beta = SR,
    Newtree = min(NewTreeL, NewTreeR).
alpha_beta(min(L,R), Alpha, Beta, Beta, Newtree) :-
    alpha_beta(L, Alpha, Beta, SL, NewTreeL),
    alpha_beta(R, Alpha, Beta, SR, NewTreeR),
    SL =< SR,
    Beta = SL,
    Newtree = min(NewTreeL, NewTreeR).
