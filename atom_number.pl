/*
atom_number(A, N)
confrontare con https://swish.swi-prolog.org/

se N non e' un numero, errore.
se A non e' convertibile in un numero, ritorna false.
atom_number('cicco', N) deve solo fallire (senza errori).

atom_number('1', 1).
atom_number('0x0A', 10).
atom_number(' 1', 1) in SWI fallisce, qui OK.
*/

% comment for SWI prolog
  atom_number(A, N) :- my_atom_number(A, N).

my_atom_number(A, N):-
    var(A), var(N), throw(error(instantiation_error, my_atom_number/2)), fail;
    nonvar(A), var(N), (
               atom(A) -> atom_codes(A, C), catch(number_codes(N, C), error(syntax_error(_),_),fail), !;
               throw(error(type_error(atom, A), my_atom_number/2))
               );
    nonvar(N), var(A), (
               number(N) -> number_codes(N, C), atom_codes(A, C), !;
               throw(error(type_error(integer, N), my_atom_number/2))
               );
	nonvar(N), nonvar(A), atom_codes(A, C), catch(number_codes(N, C), error(syntax_error(_),_),fail).   

test_atom_number :-
	atom_number('1', 1),
	atom_number('0x0A', 10),
	\+ atom_number('ciccio', _),
	(   atom_number('-10', N), N = -10),
	(   atom_number(A, -10), A = '-10').
