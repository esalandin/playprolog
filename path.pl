con(1,2).
con(1,3).
con(2,4).
con(3,4).
con(4,5).
con(3,5).

rcon(A,B):- con(A,B);con(B,A).

path(A,A,_):- !, fail.
path(A,B, [A,B]):- rcon(A,B).
path(A,B,Path):- path(A,B,_,Path).

path(A,B, X, Path):-
	path(A,X, P1), path(X,B, P2),
	remove_last(P1, PP1),
	P2=[_|PP2],
	(memberchk(X, PP1), !, fail),
	(memberchk(X, PP2), !, fail),
	append(PP1, [X|PP2], Path).
	
remove_last(I,O):- reverse(I,RI), RI=[_|RO], reverse(RO, O).

