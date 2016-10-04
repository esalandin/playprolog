con(1,2).
con(1,3).
con(2,4).
con(3,4).
con(4,5).
con(3,5).

rcon(A,B):- con(A,B).

mcon(A,B,Cost):- rcon(A,B), Cost is 1.
mcon(A,B,Cost):- rcon(A, _X), mcon(_X, B, _RemCost), Cost is _RemCost+1.
