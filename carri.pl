% posizione(id, distanza)
posizione(1, 0).
posizione(2, 10).
posizione(3, 20).
posizione(4, 30).

distanza(P,P,0):-!.
distanza(P1, P2, D):- posizione(P1, X1), posizione(P2, X2), D is abs(X2-X1).

velocita_carro(1, 1.0).
velocita_carro(2, 1.0).

distanza_minima_carri(10).

% posizione_carro(Tempo, Carro, Posizione).

posizione_iniziale([[0, 1, 1], [0, 2, 4]]).
posizione_test([[0, 1, 1], [0, 2, 4], [10,1,2], [10,2,3], [20,1, 3], [20,2,4]]).

elenco_tempi(LP, LTS, Tmin, Tmax):- findall(T, member([T, _C, _P], LP), LT), sort(LT, LTS), nth(1, LTS, Tmin), last(LTS, Tmax).
t_min(LP, T):- elenco_tempi(LP, _, T, _).
t_max(LP, T):- elenco_tempi(LP, _, _, T).

lista_posizioni_carro(LP, C, LPCS):- findall([T,P], member([T, C, P], LP), LPC), sort(LPC, LPCS).

fail_velocita([_]):-!, fail.
fail_velocita_carro(LPCS, Vel):-
	length(LPCS, L), L > 1, L1 is L-1, between(1, L1, I),  I1 is I+1,
	nth(I, LPCS, [T0, P0]), nth(I1, LPCS, [T1, P1]),
	distanza(P0, P1, D), DT is T1-T0, V is D/DT, V > Vel.
check_velocita(LP):- \+((velocita_carro(C, Vel), lista_posizioni_carro(LP, C, LPCS), fail_velocita_carro(LPCS, Vel))).

posizione_x_carro(LPCS, T, X):- member([T, P], LPCS), posizione(P, X), !.
posizione_x_carro(LPCS, T, X):- nth(1, LPCS, [T0, P0]), T < T0, posizione(P0, X), !.
posizione_x_carro(LPCS, T, X):- last(LPCS, [TL, PL]), T>TL, posizione(PL, X), !.
posizione_x_carro(LPCS, T, X):-
	findall([TL, PL], (member([TL, PL], LPCS), TL<T), LPCSP), last(LPCSP, [TLast, PLast]),  
	findall([TL, PL], (member([TL, PL], LPCS), TL>T), LPCSS), nth(1, LPCSS, [TSucc, PSucc]),
	posizione(PLast, XLast), posizione(PSucc, XSucc),
	X is XLast + (T-TLast)*((XSucc-XLast) / (TSucc-TLast)).

coppie_carri_sr(C1, C2):- velocita_carro(C1, _), velocita_carro(C2, _), C1 < C2.

fail_distanza_carri(LP, C1, C2, T):-
	distanza_minima_carri(Dmin),
	C1 \= C2,
	lista_posizioni_carro(LP, C1, LPCS1), lista_posizioni_carro(LP, C2, LPCS2),
	t_min(LP, Tmin), t_max(LP, Tmax),
	between(Tmin, Tmax, T),
	posizione_x_carro(LPCS1, T, X1), posizione_x_carro(LPCS2, T, X2),
	D is abs(X2-X1), D < Dmin, !.

check_distanza_carri(LP):- \+ (coppie_carri_sr(C1, C2), fail_distanza_carri(LP, C1, C2, _T)).
