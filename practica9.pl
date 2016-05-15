%Base de datos de vuelos
%vuelo(origen,destino,hora salida: hhmm,kilómetros,duración en minutos)

vuelo(veracruz,monterrey,1000,800,75).
vuelo(veracruz,cancun,0100,1200,115).
vuelo(veracruz,guadalajara,0900,850,90).
vuelo(veracruz,mexicali,2300,1500,135).
vuelo(veracruz,tampico,0500,500,45).
vuelo(df,la_paz,0700,750,60).
vuelo(df,tampico,0845,800,80).
vuelo(df,guadalajara,1400,600,60).
vuelo(df,saltillo,0900,550,70).
vuelo(df,monterrey,0100,450,55).
vuelo(df,chihuahua,2100,850,80).
vuelo(df,tuxtla_gutierrez,0800,1000,105).
vuelo(puebla,hermosillo,0800,700,80).
vuelo(oaxaca,cancun,1100,1300,120).
vuelo(acapulco,tampico,1000,1100,150).
vuelo(monterrey,veracruz,1300,800,70).
vuelo(cancun,veracruz,1000,1200,120).
vuelo(guadalajara,veracruz,1900,850,90).
vuelo(mexicali,veracruz,0900,1500,135).
vuelo(tampico,veracruz,0700,500,45).
vuelo(saltillo,df,0715,550,70).
vuelo(chihuahua,df,1900,850,80).
vuelo(la_paz,df,1200,750,60).
vuelo(tampico,df,1145,800,0120).
vuelo(guadalajara,df,1600,600,60).
vuelo(tuxtla_gutierrez,df,0900,1000,105).
vuelo(monterrey,df,0300,450,60).
vuelo(cancun,oaxaca,1300,1300,120).
vuelo(tampico,acapulco,1230,1100,150).


% ruta(O,D,R) cierto si hay un vuelo de la ciudad O a la ciudad D
% siguiendo la ruta R

ruta(X,Y,L1):-       ruta(X,Y,[X],L),reverse(L,L1).
ruta(X,Y,L,[Y|L]) :- X\=Y,vuelo(X,Y,_,_,_), not(member(Y,L)).
ruta(X,Y,L,W) :-     X\=Y,vuelo(X,Z,_,_,_), not(member(Z,L)),
                            ruta(Z,Y,[Z|L],W).


%Posiciones de las ciudades en el mapa
posicion(veracruz,436,374).
posicion(la_paz,122,237).
posicion(hermosillo,148,129).
posicion(monterrey,342,201).
posicion(saltillo,305,224).
posicion(chihuahua,228,150).
posicion(tampico,396,292).
posicion(guadalajara,273,336).
posicion(puebla,375,359).
posicion(df,358,343).
posicion(tuxtla_gutierrez,510,427).
posicion(acapulco,359,425).
posicion(cancun,641,313).
posicion(mexicali,27,24).
posicion(oaxaca,429,425).


% Abre una ventana para mostrar la ruta en el mapa
muestraRuta(L):-
	new(R, picture('Cálculo de Rutas Aéreas')),
	send(R, width(665)),
	send(R, height(480)),
	send(R, open),
	send(R, display, new(_, bitmap('mapa.jpg'))),
	despliegaRuta(L,R),
	distanciaKm(L,K),
	send(R, display, text(kilometros,center,normal),point(20,470)),
        send(R, display, text(K,center,normal),point(100,470)),
	duracionMin(L,D),
	send(R, display, text(duracion,center,normal),point(20,450)),
        send(R, display, text(D,center,normal),point(100,450)).



%Despliega una ruta dada una lista de ciudades.
despliegaRuta([],_).
despliegaRuta([_],_).
despliegaRuta([H1,H2|T],R):-
        posicion(H1,X1,Y1),
        posicion(H2,X2,Y2),
        send(R, display, text(H1,center,normal),point(X1,Y1)),
        send(R, display, text(H2,center,normal),point(X2,Y2)),
		send(R, display, new(_, line(X1,Y1,X2,Y2,second))),
        despliegaRuta([H2|T],R).


%Completar los predicados distanciaKm y duracion


distanciaKm([_],0).
distanciaKm([H|[HT|T]],C):-
	vuelo(H,HT,_,X,_),
	distanciaKm([HT|T],C1),
	C is C1+X.


duracionMin([_],0).
duracionMin([H|[HT|T]],C):-
	vuelo(H,HT,_,_,X),
	duracionMin([HT|T],C1),
	C is C1+X.

numVuelos(L):-
	findall(O,vuelo(O,_,_,_,_),LO),
	eliminaDuplicados(LO,LSD),
	salenVuelos(LSD,L).


salenVuelos([],[]).
salenVuelos([H|T],[C|T1]):-
	salen(H,C),
	salenVuelos(T,T1).


salen(X,N):-
	findall(O,vuelo(O,_,_,_,_),LO),
	salen(X,N,LO).
salen(X,(X,0),[]).
salen(X,(X,C),[X|T]):-
	salen(X,(X,C1),T),
	C is C1+1.
salen(X,(X,C),[_|T]):-
	salen(X,(X,C),T).


encuentra(H,[H|_]).
encuentra(H,[_|T]):-
	encuentra(H,T).

eliminaDuplicados([],[]).
eliminaDuplicados([H|T],L):-
	encuentra(H,T),
	eliminaDuplicados(T,L).
eliminaDuplicados([H|T],[H|L]):-
	eliminaDuplicados(T,L).



pasaPor(O,D,[H|_]):-
	ruta(O,D,L),
	member(H,L).
pasaPor(O,D,[_|T]):-
	pasaPor(O,D,T).


