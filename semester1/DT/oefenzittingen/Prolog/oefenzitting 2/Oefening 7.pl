alpha_beta(leaf(X,S),_Alpha,_Beta,X,leaf(X,S)).
   
alpha_beta(min(X,_Y),Alpha,Beta,ScoreX,min(NewtreeX,nill)):-
    alpha_beta(X,Alpha,Beta,ScoreX,NewtreeX),
    Alpha >= ScoreX,
    !.
 
alpha_beta(min(X,Y),Alpha,Beta,Score,min(NewtreeX,NewtreeY)):-
    alpha_beta(X,Alpha,Beta,ScoreX,NewtreeX),
    alpha_beta(Y,Alpha,ScoreX,ScoreY,NewtreeY),
    Score is min(ScoreX,ScoreY).


alpha_beta(max(X,_Y),Alpha,Beta,ScoreX,max(NewtreeX,nill)):-
    alpha_beta(X,Alpha,Beta,ScoreX,NewtreeX),
    ScoreX >= Beta,
    !.

alpha_beta(max(X,Y),Alpha,Beta,Score,max(NewtreeX,NewtreeY)):-
    alpha_beta(X,Alpha,Beta,ScoreX,NewtreeX),
    alpha_beta(Y,ScoreX,Beta,ScoreY,NewtreeY),
    Score is max(ScoreX,ScoreY).
