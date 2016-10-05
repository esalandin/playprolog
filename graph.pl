con(1,2).
con(1,3).
con(2,4).
con(3,4).
con(4,5).
con(3,5).

rcon(A,B):- con(A,B).

mcon(A,B,Cost,Path):- rcon(A,B), Cost is 1, Path = [B].
mcon(A,B,Cost,Path):- rcon(A, _X), mcon(_X, B, _RemCost, _RemPath), Cost is _RemCost+1, Path=[_X|_RemPath], (memberchk(A, Path), !, fail; true).

test:-
	mcon(1,2,1,[2]),
	mcon(1,5,3,[2,4,5]),
	mcon(1,5,2,[3,5]),
	true.