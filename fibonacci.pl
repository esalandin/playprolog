% example of memoization

:- dynamic(fib_store/2).

fib(N,F):-fib_store(N,F),!.
fib(1,1).
fib(2,1).
fib(N,F):-
	N>2,
	PN is N-1,
	PPN is PN-1,
	fib(PN, F1),
	fib(PPN,F2),
	F is F1+F2,
	assertz(fib_store(N,F)).
