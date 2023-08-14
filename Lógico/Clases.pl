%   Clase 1
% BASE DE CONOCIMIENTOS

%escribio(Autor, Obra) -> hecho (hay 24 claúsulas)
escribio(elsaBornemann, socorro).
escribio(neilGaiman, sandman).
escribio(alanMoore, watchmen).
escribio(brianAzarello, cienBalas).
escribio(warrenEllis, planetary).
escribio(frankMiller, elCaballeroOscuroRegresa).
escribio(frankMiller, batmanAnioUno).
escribio(neilGaiman, americanGods).
escribio(neilGaiman, buenosPresagios).
escribio(terryPratchett, buenosPresagios).
escribio(isaacAsimov, fundacion).
escribio(isaacAsimov, yoRobot).
escribio(isaacAsimov, elFinDeLaEternidad).
escribio(isaacAsimov, laBusquedaDeLosElementos).
escribio(joseHernandez, martinFierro).
escribio(stephenKing, it).
escribio(stephenKing, misery).
escribio(stephenKing, carrie).
escribio(stephenKing, elJuegoDeGerald).
escribio(julioCortazar, rayuela).
escribio(jorgeLuisBorges, ficciones).
escribio(jorgeLuisBorges, elAleph).
escribio(horacioQuiroga, cuentosDeLaSelva).
escribio(horacioQuiroga, cuentosDeLocuraAmorYMuerte).

% Agregamos qué obras son cómics.

esComic(sandman).
esComic(cienBalas).
esComic(watchmen).
esComic(planetary).
esComic(elCaballeroOscuroRegresa).
esComic(batmanAnioUno).

% Queremos saber si alguien es artista del noveno arte (comics).
% Lo resolvemos por comprensión.
% esArtistaDelNovenoArte/1 predicado con dos claúsulas (una regla y un hecho).

% p ^ q => r -> en discreta
% r <= p ^ q -> en lógico

esArtistaDelNovenoArte(Artista) :- % regla
  escribio(Artista, Obra),
  esComic(Obra).

% En lógico no asignamos. Sí ligamos o unificamos, por eso no hace falta decir que la "Obra" es la misma.

% Y si también queremos aclarar que Art Spiegelman es un artista del noveno arte, hacemos:

esArtistaDelNovenoArte(artSpiegelman). % hecho

% Un artista es reincidente si escribió al menos 2 obras.

esReincidente(Artista) :-
  escribio(Artista, UnaObra),
  escribio(Artista, OtraObra),
  UnaObra \= OtraObra.

% Un predicado inversible me permite realizar consultas existenciales (pasar un _ o una variable sin ligar), además de las invididuales.

% Una obra le gusta a Gus si es Sandman o la escribió Isaac Asimov. Tiene que ser inversible.

leGustaAGus(sandman).

leGustaAGus(Obra):-
  escribio(isaacAsimov, Obra).


%Ambas alternativas son igual de válidas. La única diferencia es que en una se modela a gus como un individuo y en la otra es el nombre del predicado el que indica a quién le gusta la obra.

% Una obra es un libro cuando NO es un comic.
% not no es inversible!! No puede ligar las variables dentro de su predicado.
% Si a esLibro no le agregamos el generador, no sería un predicado inversible porque el not no es inversible.
% El generador nos "achica" el universo de opciones.

esLibro(Obra) :-
  esObra(Obra), % generador para que esLibro sea inversible
  not(esComic(Obra)).

esObra(Obra) :-
  escribio(_, Obra).

% Una obra es un bestseller si vendió más de 50mil copias.

% copiasVendidas(Obra,Cantidad)

copiasVendidas(socorro, 10000).
copiasVendidas(sandman, 20000).
copiasVendidas(watchmen, 30000).
copiasVendidas(cienBalas, 40000).
copiasVendidas(planetary, 50000).
copiasVendidas(elCaballeroOscuroRegresa, 60000).
copiasVendidas(batmanAnioUno, 70000).
copiasVendidas(americanGods, 80000).
copiasVendidas(buenosPresagios, 90000).
copiasVendidas(buenosPresagios, 10000).
copiasVendidas(fundacion, 20000).
copiasVendidas(yoRobot, 30000).
copiasVendidas(elFinDeLaEternidad, 30000).
copiasVendidas(laBusquedaDeLosElementos, 40000).
copiasVendidas(martinFierro, 50000).
copiasVendidas(it, 60000).
copiasVendidas(it, 70000).
copiasVendidas(misery, 70000).
copiasVendidas(carrie, 80000).
copiasVendidas(elJuegoDeGerald, 90000).
copiasVendidas(rayuela, 10000).
copiasVendidas(ficciones, 20000).
copiasVendidas(elAleph, 30000).
copiasVendidas(cuentosDeLaSelva, 40000).
copiasVendidas(cuentosDeLocuraAmorYMuerte, 50000).

% Una obra es un bestseller si vendió más de 50mil copias.

esBestseller(Obra) :-
  copiasVendidas(Obra, CantidadDeCopias),
  CantidadDeCopias > 50000.


% Conviene contratar un artista si:
% escribió un bestseller o
% es reincidente.
% Tiene que ser inversible.

convieneContratar(UnArtista) :-
  escribio(UnArtista, UnaObra),
  esBestseller(UnaObra).

convieneContratar(UnArtista) :-
  esReincidente(UnArtista).

%Queremos saber si una obra es rioplatense:
% que es cuando la nacionalidad de su artista es
% platense (Uruguay o Argentina).
% ¡Ojo con repetir lógica!

nacionalidad(elsaBornemann, argentina).
nacionalidad(joseHernandez, argentina).
nacionalidad(julioCortazar, argentina).
nacionalidad(jorgeLuisBorges, argentina).
nacionalidad(horacioQuiroga, uruguaya).
nacionalidad(neilGaiman, britanica).
nacionalidad(alanMoore, britanica).
nacionalidad(warrenEllis, britanica).
nacionalidad(terryPratchett, britanica).
nacionalidad(brianAzarello, estadounidense).
nacionalidad(frankMiller, estadounidense).
nacionalidad(stephenKing, estadounidense).
nacionalidad(isaacAsimov, rusa).



esObraRioplatense(Obra):-
  escribio(Autor,Obra),
  nacionalidad(Autor,Nacionalidad),
  esNacionalidadPlatense(Nacionalidad).

esNacionalidadPlatense(uruguaya).

esNacionalidadPlatense(argentina).

% para todas las obras que escribió un artista, la obra es comic

soloEscribioComics(Artista):-
  escribio(Artista,_),
  forall(escribio(Artista,Obra), esComic(Obra)).
%        ||||||||||||||||||||||  ||||||||||||||
%          antecedente             consecuente


todasLasObrasSonComics:-
  forall(escribio(_,Obra),esComic(Obra)).

soloEscribioComicsBestSeller(Artista):-
  escribio(Artista,_),
  forall(escribio(Artista,Obra),esComicYBestseller(Obra)).

esComicYBestseller(Obra):-
  esComic(Obra),
  esBestseller(Obra).


% Functores!

% componente(ingrediente, gramos)

% novela(Genero, Capitulos)
% libroDeCuentos(CantidadDeCuentos)
% librosCientificos(Disciplina)
% bestSeller(Precio,CantidadDePaginas)

esDeGenero(it,                      novela(terror, 11)).
esDeGenero(cuentosDeLaSelva,        libroDeCuentos(10)).
esDeGenero(elUniversoEnUnaTabla,    libroCientifico(quimica)).
esDeGenero(elUltimoTeoremaDeFermat, libroCientifico(matematica)).
esDeGenero(yoRobot,                 bestSeller(700, 253)).
esDeGenero(oyasumiPunpun,           manga).

esDeGenero(sandman, fantastica([yelmo, bolsaDeArena, rubi])).

/*
estaBuena/1 nos dice cuando una obra está buena.
Esto sucede cuando:
- Es una novela policial y tiene menos de 12
  capítulos.
- Es una novela de terror.
- Los libros con más de 10 cuentos siempre son
  buenos.
- Es una obra científica de fisicaCuantica.
- Es un best seller y el precio por página es
  menor a $50.
*/


% Polimorfismo

estaBuena(Obra):-
  esDeGenero(Obra, Tipo),
  esBuenGenero(Tipo).

esBuenGenero(novela(policial, Capitulos)):-
  Capitulos < 12.

esBuenGenero(novela(terror, _)).

esBuenGenero(libroDeCuentos(CantidadDeCuentos)):-
  CantidadDeCuentos > 10.

esBuenGenero(cientifico(fisicaCuantica)).

esBuenGenero(bestSeller(Precio, Paginas)):-
  Precio / Paginas < 50.


% Clase 3

/* cantidadDePaginas/2 relaciona a una obra con su cantidad de páginas:
- las novelas tienen 20 páginas por capítulo;
- los libros de cuentos 5 páginas por cuento;
- las obras científicas tienen siempre 1000 páginas;
- de los best sellers ya sabemos su cantidad de páginas.
*/

cantidadDePaginas(Obra,CantidadDePaginas):-
  esDeGenero(Obra , Genero),
  paginasPorGenero(Genero, CantidadDePaginas).

paginasPorGenero(novela(_, Capitulos), CantidadDePaginas):-
  CantidadDePaginas is Capitulos * 20.

paginasPorGenero(libroDeCuentos(Cuentos), CantidadDePaginas):-
  CantidadDePaginas is Cuentos * 5.

paginasPorGenero(cientifico(_),1000).

paginasPorGenero(bestSeller(_,CantidadDePaginas), CantidadDePaginas).

% Queremos saber el puntaje de un autor, 
% este se calcula como `3 * cantidad de obras best seller que escribió. 
% Recordemos que ya tenemos un predicado esBestSeller

tienePuntaje(Autor, Puntaje) :-
  cantidadObrasBestSellerQueEscribio(Autor, Cantidad),
  Puntaje is 3 * Cantidad.

escribioBestSeller(Autor, Obra) :- 
  escribio(Autor, Obra),
  esBestseller(Obra).

cantidadObrasBestSellerQueEscribio(Autor, Cantidad) :-
  obrasBestSellerQueEscribio(Autor, BestSellers),
  length(BestSellers, Cantidad).

obrasBestSellerQueEscribio(Autor, BestSellers) :-
    escribio(Autor,_),
    findall(Obra, escribioBestSeller(Autor, Obra), BestSellers).





obrasBestSellerQueLeGustanAGus(Obras):-
    findall(Obra,leGustaAGusBestseller(Obra),Obras).

leGustaAGusBestseller(Obra):-
    leGustaAGus(Obra),
    esBestseller(Obra).



% se incorpora un nuevo tipo de obra: fantástica(ElementosMagicos)

esBuenGenero(fantastica(ElementosMagicos)):-
  member(rubi, ElementosMagicos).


% Queremos saber el promedio de copias vendidas del autor

promedioCopiasVendidas(Autor, Promedio):-
  escribio(Autor,_),
  findall(Copias,ventasDeUnaObraDeUnAutor(Autor,Copias),ListaDeCopias),
  promedio(ListaDeCopias, Promedio).

promedio(Lista, Promedio):-
  length(Lista, Cantidad),
  sum_list(Lista, Suma),
  Promedio is Suma / Cantidad.

ventasDeUnaObraDeUnAutor(Autor,Cantidad):-
  escribio(Autor,Obra),
  copiasVendidas(Obra,Cantidad).
