eliminaDuplicados([],[]).
eliminaDuplicados([H|T],S):- member(H,T), !, eliminaDuplicados(T,S).
eliminaDuplicados([H|T],[H|S]):- eliminaDuplicados(T,S).

generaLista(0,[]).
generaLista(N,[H|L]):- N>0, intervalo(1,N,[H|L]),!.

intervalo(X,X,[X]).
intervalo(X,Y,[X|Xs]):-X < Y, Z is X + 1, intervalo(Z,Y,Xs).

combinaciones(L1,N,L2):-
    findall(L,combina(L1,N,L),L2).
	
combina(_,0,[]).
combina([X|T],N,[X|Comb]):- N>0, N1 is N-1, combina(T,N1,Comb).
combina([_|T],N,Comb):- N>0, combina(T,N,Comb).  

reinas(N,L2):-
    findall(L,reina(N,L),L2).

reina(N,Sol):- generarTablero(N,Tablero),
permutar(Tablero,Sol),
buenTablero(Sol).

generarTablero(0,[]).
generarTablero(X,[X|R]):-
XMenos1 is X - 1,
XMenos1 >= 0,
generarTablero(XMenos1,R).

permutar([],[]).
permutar(X,[C|Z]) :- seleccionar(X,C,R), permutar(R,Z).

seleccionar([X|R],X,R).
seleccionar([C|R],X,[C|Y]) :- seleccionar(R,X,Y).

buenTablero([]).
buenTablero([C|R]):- not(amenaza(C,R)),
buenTablero(R).

amenaza(X,Prof,[C|_]):- X is C+Prof;
X is C-Prof;
X = C.
amenaza(X,Prof,[_|R]):- ProfMas1 is Prof + 1,
amenaza(X,ProfMas1,R).

amenaza(_,[]):- fail.
amenaza(X,Y):- amenaza(X,1,Y).
