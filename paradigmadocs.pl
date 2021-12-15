%Tda Fecha---------------------------
%de la forma: Dia(int), mes(int), anio(int)
date(Dia,Mes,Anio,[Dia,Mes,Anio]):- Dia > 0, Dia < 32,Mes > 0 ,Mes < 13, Anio >= 1900, Anio < 2022.

getDay([Dia|_], SDay):- Dia= SDay.
getMonth([_,Mes|_], SMonth):- Mes = SMonth.
getYea([_,_,Anio|_], SYear):- Anio = SYear.

%TDA User---------------------------
%de la forma: nombre(string), contraseña(string), fecha(date),
user(Username, Password, Date, [Username, Password, Date]).
sameUsername([Username1|_],[Username1|_]).
samePassword([_,Pass1|_],[_,Pass1|_]).

%TDA Docs--------------------------
% de la forma: nombre(string), fecha creación(date), id del
% documento(int), lista de versiones(list), lista de accesos(access)
docsCreate(Name, FechaCreacion, Id, [Name, FechaCreacion,Id, "",[]]).

%TDA Access-----------------------

%Tda Paradigmadocs----------------
% de la forma: nombre de la plataforma(string), fecha de creacion(date),
% usuario activo(string), usuarios registrados(list), documentos(list).
paradigmaDocs(Name, Date, [Name, Date, "", [],[]]).

setUsersPrdc([Name,Date,Log,_,Docs|_],NewUsers,[Name,Date,Log,NewUsers,Docs]).
setLogPrdc([Name,Date,_,Users,Docs|_],NewLog,[Name,Date,NewLog,Users,Docs]).
setDocsPrdc([Name,Date,Log,Users,_|_],NewDocs,[Name,Date,Log,Users,NewDocs]).

getUsersPrdc([_,_,_,Users,_|_],Users).
getLogPrdc([_,_,Log,_,_|_],Log).
getDocsPrdc([_,_,_,_,Docs|_],Docs).

existlog(Sn):-not(getLogPrdc(Sn,"")).

%dominio: lista usuarios, user
existUsername([],_):- !, fail.
existUsername([FU|_],User):- sameUsername(FU,User),!,true.
existUsername([_|LU],User):- existUsername(LU,User).

existUser([],_):- !, fail.
existUser([FU|_],User):- sameUsername(FU,User), samePassword(FU,User),!,true.
existUser([_|LU],User):- existUser(LU,User).

contarlista([],Count,Count).
contarlista([_|L],Count,Total):- contarlista(L,(Count+1),Total).

%requerimientos============
paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2):-user(Username,Password, Fecha, US),getUsersPrdc(Sn1,LU), not(existUsername(LU,US)), setUsersPrdc(Sn1,[US|LU],Sn2).

paradigmaDocsLogin(Sn1, Username, Password, Sn2):-user(Username,Password, [1,2,2020], US) ,getUsersPrdc(Sn1,LU), existUser(LU,US),setLogPrdc(Sn1,Username,Sn2).

paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2):-existlog(Sn1),getDocsPrdc(Sn1,LD),contarlista(LD,0,Largo),docsCreate(Nombre,Fecha,Largo,D1),setDocsPrdc(Sn1,[D1,LD],Sn2).

%testeos========================================
test1(PD4):- date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmaDocs("google docs", D1, PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4).

test2(PD6):- date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmaDocs("google docs", D1, PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4), paradigmaDocsLogin(PD4, "vflores", "hola123", PD5), paradigmaDocsCreate(PD5, D2, "archivo 1", "hola mundo, este es el contenido de un archivo", PD6).
