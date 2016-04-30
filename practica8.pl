eliminaDuplicados([],[]).
eliminaDuplicados([H|T],S):- member(H,T), !, eliminaDuplicados(T,S).
eliminaDuplicados([H|T],[H|S]):- eliminaDuplicados(T,S).

%% falta que se genere la lista de 1 a N
generaLista(0,[]).
generaLista(N,[N|L]):- N1 is N-1, N2 is N1+1, generaLista(N2,L).

%% falta que la salida sea una lista de listas
combinaciones(_,0,[]).
combinaciones([X|T],N,[X|Comb]):- N>0, N1 is N-1, combinaciones(T,N1,Comb).
combinaciones([_|T],N,Comb):- N>0, combinaciones(T,N,Comb).  

%% falta que la salida sea una lista de listas y en el autismo, que salga como en el ejemplo de la practica,
%% sino sale ordenada de n a n-1
reinas(N,Sol):- generarTablero(N,Tablero),
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
