% task(id,durata,[lista risorse])
task(a,10,[r,ra]).
task(b,10,[r,rb]).
task(c,15,[r,rc]).
task(d,10,[r,rd]).

link_fs(a,b).
link_fs(a,c).
link_fs(b,d).
link_fs(c,d).

overlap([I1T0, I1T1], [I2T0, I2T1]):-
	in_interval(I2T0, [I1T0, I1T1]); in_interval(I2T1, [I1T0, I1T1]),
	in_interval(I1T0, [I2T0, I2T1]); in_interval(I1T1, [I2T0, I2T1]).
in_interval(X, [T0, T1]):- T0=<X, X<T1.

double_entry(S):- member([_T, St1], S), member([_T, St2], S), St1\=St2.
valid_schedule(S):- member([T, StartT], S), link_fs(Pred,T), member([Pred, StartPred], S), task(Pred,DurPred,_), StartT >= StartPred+DurPred.
