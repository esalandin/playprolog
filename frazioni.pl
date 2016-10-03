% massimo comun divisore
mcd(X,0,X) :- !.
mcd(X,Y,Z) :- Y>0, X1 is X mod Y, mcd(Y,X1,Z).

is_fraction(F) :- is_list(F), length(L,2).

semplifica([N,D],[NS,DS]) :-
    mcd(N,D,1), NS is N, DS is D, !;
    mcd(N,D,_Z), NS is N div _Z, DS is D div _Z.

somma([AN,AD], [BN, BD], S) :-
    _TSD is AD * BD, _TSN is AN * BD + BN * AD, semplifica([_TSN,_TSD],S).

prodotto([AN,AD], [BN, BD], P) :-
        _TPD is AD * BD, _TPN is AN * BN, semplifica([_TPN,_TPD],P).

potenza(F,0, [1,1]) :- !.
potenza(F,N,Pot) :- N>0, _PN is N - 1, potenza(F,_PN, _TPot), prodotto(F,_TPot,Pot).

% tests
test:- 
    semplifica([12,4], [3,1]),
	somma([1,2], [3,2], [2,1]),
    prodotto([2,3], [3,2], [1,1]),
	potenza([2,3], 2, [4,9]),
	true.
