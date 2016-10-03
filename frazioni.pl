% massimo comun divisore
mcd(X,0,X) :- !.
mcd(X,Y,Z) :- Y>0, X1 is X mod Y, mcd(Y,X1,Z).

is_fraction(F) :- is_list(F), length(F,2).

semplifica([N,D],F) :-
    mcd(N,D,_Z), _NS is N div _Z, _DS is D div _Z, (_DS == 1, F is _NS, !; F = [_NS,_DS]).

somma([AN,AD], [BN, BD], S) :-
    _TSD is AD * BD, _TSN is AN * BD + BN * AD, semplifica([_TSN,_TSD],S), !.
	
somma(A, B, S) :- \+ is_fraction(B), somma(A,[B,1],S), !.
somma(A, B, S) :- \+ is_fraction(A), somma([A,1],B,S), !.

prodotto([AN,AD], [BN, BD], P) :-
        _TPD is AD * BD, _TPN is AN * BN, semplifica([_TPN,_TPD],P), !.

prodotto(A, B, S) :- \+ is_fraction(B), prodotto(A,[B,1],S), !.
prodotto(A, B, S) :- \+ is_fraction(A), prodotto([A,1],B,S), !.


potenza(_F,0, [1,1]) :- !.
potenza(F,N,Pot) :- N>0, _PN is N - 1, potenza(F,_PN, _TPot), prodotto(F,_TPot,Pot).

% tests
test:- 
    semplifica([12,4], [3,1]),
	semplifica([12,4], 3),
	somma([1,2], [3,2], [2,1]),
    prodotto([2,3], [3,2], [1,1]),
	potenza([2,3], 2, [4,9]),
	
	somma([1,2],1,[3,2]),
	somma(2,[1,2], [5,2]),
	somma(1,2,[3,1]),
	prodotto(3,5,[15,1]),
	potenza(2,8,[256,1]),
	
	semplifica([3,1],[3,1]),
	semplifica([3,1], 3),
	
	prodotto([5,2], [2,5], _X), _X == 1,
	
	true.
