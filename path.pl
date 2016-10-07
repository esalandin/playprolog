con(1,2).
con(1,3).
con(2,4).
con(3,4).
con(4,5).
con(3,5).

rcon(A,B):- con(A,B);con(B,A). % bidirezionali

pathfinder(A,B, OldPath, NewPath, Cost):-
	rcon(A,B),
	addpath(OldPath, B, _), % controlla che B non sia gia' sul percorso.
	NewPath=[B],
	Cost is 1.

pathfinder(A,B, OldPath, NewPath, Cost):-
	rcon(A,X),
	addpath(OldPath,X,XP),
	pathfinder(X,B,XP, RemPath, RemCost),
	NewPath=[X|RemPath],
	Cost is RemCost+1.

addpath(Path,X,NewPath):-
	memberchk(X, Path),!, fail;
	NewPath=[X|Path].

% path con il primo nodo in testa.
path(A,B,P,C) :- pathfinder(A,B, [A], Path, C), P=[A|Path].

path_cost_couple(A,B,[C,P]):- path(A,B,P,C).
path_cost_list(A,B,L):- bagof(_Couple, path_cost_couple(A,B,_Couple),L).

list_min([L|Ls], Min) :-
    list_min(Ls, L, Min).
list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-
    % Min1 is min(L, Min0),
	[Lcost,_LP]= L, [Min0Cost,_Min0Cost]= Min0, (Lcost<Min0Cost, Min1=L,!; Min1=Min0),
    list_min(Ls, Min1, Min).

min_path_cost_couple(A,B,C):- path_cost_list(A,B,List), list_min(List, C).

minpath(A,B,Path,Cost):- min_path_cost_couple(A,B,[Cost, Path]).
	
test:-
	path(1,5,[1,3,5],2),
	path(1,5,[1,2,4,3,5],4),
	minpath(1,5,[1,3,5],2),
	true.
