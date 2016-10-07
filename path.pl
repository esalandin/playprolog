con(1,2).
con(1,3).
con(2,4).
con(3,4).
con(4,5).
con(3,5).

rcon(A,B):- con(A,B);con(B,A).

pathfind(A,B, OldPath, NewPath, Cost):-
	rcon(A,B),
	addpath(OldPath, B, _), % controlla che B non sia gia' sul percorso.
	NewPath=[B],
	Cost is 1.

pathfind(A,B, OldPath, NewPath, Cost):-
	rcon(A,X),
	addpath(OldPath,X,XP),
	pathfind(X,B,XP, RemPath, RemCost),
	NewPath=[X|RemPath],
	Cost is RemCost+1.

addpath(Path,X,NewPath):-
	memberchk(X, Path),!, fail;
	NewPath=[X|Path].
