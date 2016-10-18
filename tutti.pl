% tutti i membri di una lista soddisfano una condizione
pari(N):- 0 is N rem 2.
tutti_pari(L):- forall(member(M,L), pari(M)).

% equivalente a:
tutti_pari2(L):- \+ (member(M,L), \+ pari(M)).

test:-
	tutti_pari([0, 2, 4]),
	\+ tutti_pari([0, 1, 4]).
