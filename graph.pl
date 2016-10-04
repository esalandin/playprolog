con(1,2).
con(1,3).
con(2,4).
con(3,4).
con(4,5).

rcon(A,B):- con(A,B).

mcon(A,B):- rcon(A,B).
mcon(A,B):- rcon(A, _C), mcon(_C, B).
