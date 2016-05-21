%% Arboles en Prolog
dibuja(L):-
               new(P, picture('Arbol')),
               send(P, width(1000)),
               send(P, height(600)),
               send(P, open),
               dibujaArbol(L,530,20,P).

dibujaArbol(arbol(N,nulo,nulo),X,Y,P):-
	send(P, display, text(N,center,normal),point(X+5,Y)).
dibujaArbol(arbol(N,nulo,D),X,Y,P):-
	Yp is Y + 60,
	escalad(X,Y,Xd),
	send(P, display, text(N,center,normal),point(X+5,Y)),
        send(P, display, new(_, line(X+8,Y+15,Xd+8,Yp,second))),
	dibujaArbol(D,Xd,Yp,P).
dibujaArbol(arbol(N,I,nulo),X,Y,P):-
	escalai(X,Y,Xi),
	Yp is Y + 60,
	send(P, display, text(N,center,normal),point(X+5,Y)),
	send(P, display, new(_, line(X+10,Y+15,Xi+8,Yp,second))),
	dibujaArbol(I,Xi,Yp,P).
dibujaArbol(arbol(N,I,D),X,Y,P):-
	escalai(X,Y,Xi),
        escalad(X,Y,Xd),
	Yp is Y + 60,
	send(P, display, text(N,center,normal),point(X+5,Y)),
        send(P, display, new(_, line(X+8,Y+15,Xd+8,Yp,second))),
	send(P, display, new(_, line(X+10,Y+15,Xi+8,Yp,second))),
	dibujaArbol(D,Xd,Yp,P),
        dibujaArbol(I,Xi,Yp,P).

escalai(X,Y,Z):-
        Z is X - (200 - Y/1.5).
escalad(X,Y,Z):-
        Z is X + (200 - Y/1.5).

% Ejemplo de un arbol para utilizarlo en los ejercicios
ejemploArbol(
     arbol(150,
        arbol(100,
            arbol(30,
              arbol(10,nulo,nulo),
              arbol(70,nulo,nulo)
            ),
            arbol(120,nulo,nulo)
        ),
        arbol(250,
            arbol(200,nulo,nulo),
            arbol(300,
                arbol(270,
                    arbol(260,nulo,nulo),
                    arbol(290,nulo,nulo)
                ),
                arbol(450,nulo,nulo)
            )
        )
     )
).

% hijos
hijos(N,arbol(N,arbol(R, _, _),arbol(R2,_,_)),H):- concatena([R],[R2],H).
hijos(N,arbol(R,I,_),H):- N<R,hijos(N,I,H).
hijos(N,arbol(R,_,D),H):- N>R,hijos(N,D,H).

concatena([],L,L).
concatena(L,[],L).
concatena([H|T],L,[H|L1]):- concatena(T,L,L1).

% elimina un nodo
eliminaArbol(N,arbol(N,I,nulo),I).
eliminaArbol(N,arbol(N,nulo,D),D).
eliminaArbol(N,arbol(R,I,D),arbol(R,I1,D)):- N<R, eliminaArbol(N,I,I1).
eliminaArbol(N,arbol(R,I,D),arbol(R,I,D1)):- N>R, eliminaArbol(N,D,D1).
eliminaArbol(N,arbol(N,I,D),arbol(N1,I1,D)):- menor(I,N1), eliminaArbol(N1,I,I1).

menor(arbol(R,_,nulo),R).
menor(arbol(_,_,D),D1):- menor(D,D1).
