con(1,2).
con(1,3).
con(2,4).
con(3,4).
con(4,5).
con(3,5).

rcon(A,B):- con(A,B);con(B,A).

mcon(A,B,Cost,Path):- rcon(A,B), Cost is 1, Path = [B].
mcon(A,B,Cost,Path):-
    rcon(A, _X),
    mcon(_X, B, RemCost, RemPath),
    newpath(_X, Path),
    Cost is RemCost+1,
    Path=[_X|RemPath].

newpath(Node, Path) :- memberchk(Node, Path), !, fail; true.

% path con il primo nodo in testa.
mconp(A,B,C,P) :- mcon(A,B,C, _Path), P=[A|_Path].

path_cost_couple(A,B,[C,P]):- mconp(A,B,C,P).
path_cost_list(A,B,L):- bagof(_Couple, path_cost_couple(A,B,_Couple),L).

list_min([L|Ls], Min) :-
    list_min(Ls, L, Min).
list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-
    % Min1 is min(L, Min0),
	[Lcost,_LP]= L, [Min0Cost,_Min0Cost]= Min0, (Lcost<Min0Cost, Min1=L,!; Min1=Min0),
    list_min(Ls, Min1, Min).

min_path_cost_couple(A,B,C):- path_cost_list(A,B,List), list_min(List, C).

min_path(A,B,Path):- min_path_cost_couple(A,B,[_Cost, Path]).
	
test:-
	mcon(1,2,1,[2]),
	mcon(1,5,3,[2,4,5]),
	mcon(1,5,2,[3,5]),
	mconp(1,5,2,[1,3,5]),
	min_path(1,5,[1,3,5]),
	true.
