%Tda Fecha
%de la forma: Dia(int), mes(int), anio(int)
date(Dia,Mes,Anio,[Dia,Mes,Anio]):- Dia > 0, Dia < 32,Mes > 0 ,Mes < 13, Anio >= 1900, Anio < 2022.

getDay([Dia|_], SDay):- Dia= SDay.
getMonth([_,Mes|_], SMonth):- Mes = SMonth.
getYea([_,_,Anio|_], SYear):- Anio = SYear.

%TDA User
%de la forma: nombre(string), contrase�a(string), fecha(date),
user(Username, Password, Date, [Username, Password, Date]).

%TDA Docs
% de la forma: nombre(string), fecha creaci�n(date), id del
% documento(int), lista de versiones(list), lista de accesos(access)
docsCreate(Name, FechaCreacion, Id, [Name, FechaCreacion,Id, [],[]]).

combinaciondetodo(Sout):- date(1,2,2020,D1),user("sebastian","peo",D1, Us1),docsCreate("Lasa�a", D1,0, Doc1), Sout = [D1,Us1,Doc1].

%TDA Access
%Tda Paradigmadocs
% de la forma: nombre de la plataforma(string), fecha de creacion(date),
% usuario activo(string), usuarios registrados(list), documentos(list).
paradigmaDocs(Name, Date, [Name, Date, "", [],[]]).



