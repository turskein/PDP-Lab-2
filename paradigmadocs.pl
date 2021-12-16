%Tda Fecha------------------------------------------------------
%---------------------------------------------------------------
%de la forma: Dia(int), mes(int), anio(int)
date(Dia,Mes,Anio,[Dia,Mes,Anio]):- Dia > 0, Dia < 32,Mes > 0 ,Mes < 13, Anio >= 1900, Anio < 2022.

getDay([Dia|_], SDay):- Dia= SDay.
getMonth([_,Mes|_], SMonth):- Mes = SMonth.
getYea([_,_,Anio|_], SYear):- Anio = SYear.

%TDA User--------------------------------------------------------
%----------------------------------------------------------------
%de la forma: nombre(string), contraseña(string), fecha(date),
user(Username, Password, Date, [Username, Password, Date]).
sameUsername([Username1|_],[Username1|_]).
samePassword([_,Pass1|_],[_,Pass1|_]).

%TDA Docs--------------------------------------------------------
%----------------------------------------------------------------
% de la forma: nombre(string), fecha creación(date), id del
% documento(int), lista de versiones(list), lista de accesos(access)
docsCreate(Name, FechaCreacion, Id, Owner,[Name, FechaCreacion,Id, Owner,"",[]]).

addContent([Name, FechaCreacion,Id,Owner,Content,Access|_],NewContent,[Name, FechaCreacion,Id, Owner,SAdd,Access]):- string_concat(Content,NewContent,SAdd).

getId([_,_,Id|_],Id).
getContent([_,_,_,Content,_|_],Content).
getAccesses([_,_,_,_,_,Accesses], Accesses).

setAccesses([Name, FechaCreacion,Id, Owner,Content,_|_],NewAccesses,[Name, FechaCreacion,Id, Owner,Content,NewAccesses]).

isOwner([_,_,_,Owner|_],Owner).

canWhatinDocs([_,_,_,Owner|_],Owner,_):-!,true.
canWhatinDocs([_,_,_,_,_,LA|_],Name,Letter):-getAccessSomeUser(LA,Name,SAC),getListAccessUser(SAC,LAU),canWhat(LAU,Letter).


%lista de accesos(list from docs), Name(string)
getAccessSomeUser([],_,_):-!,fail.
getAccessSomeUser([FAU|_],Name,AFU):- getNameAccess(FAU,Name), FAU = AFU.
getAcessSomeUser([_|LAU],Name,AFU):- getAcessSomeUser(LAU,Name,AFU).

% dominio: lista de accesos del doc(list accessess from doc), acceso a
% agregar (access)
addOneAccess([],Access,[Access]).
addOneAccess([LastAccess|NextAccesses],Access,[Access|NextAccesses]):- getNameAccess(LastAccess,Name1),getNameAccess(Access,Name1),!.
addOneAccess([LastAccess|NextAccess],Access,[LastAccess|Accesses]):-addOneAccess(NextAccess,Access,Accesses).

% dominio: lista nombres usuarios(list usernames), lista permisos(list),
% lista de accesos del documento(list access from doc)
addMultiplyAccesses([],_,OldAccesses,OldAccesses):-!.
addMultiplyAccesses([LastUsername|NextUsernames],Permissions,OldAccesses,NewAccesses):-addMultiplyAccesses(NextUsernames,Permissions,OldAccesses,NextNew),access(LastUsername,Permissions,A),addOneAccess(NextNew,A,NewAccesses).

%TDA Access------------------------------------------------------------
% ---------------------------------------------------------------------
% de la forma nombre usuario(string), lista de accesos del user(list)
access(Name,LA,[Name,LA]).

getNameAccess([Name|_],Name).
getListAccessUser([_,LA|_],LA).
% lista de accesos del user(list from access), tipo de acceso a
% buscar(CHAR)
canWhat([],_):- !,fail.
canWhat([FA|_],FA):- !, true.
canWhat([_|LAU],Letter):-canWhat(LAU,Letter).

%Tda Paradigmadocs----------------------------------------------------
%---------------------------------------------------------------------
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

existUsername([],_):- !, fail.
existUsername([FU|_],User):- sameUsername(FU,User),!,true.
existUsername([_|LU],User):- existUsername(LU,User).

existUser([],_):- !, fail.
existUser([FU|_],User):- sameUsername(FU,User), samePassword(FU,User),!,true.
existUser([_|LU],User):- existUser(LU,User).

contarlista([],Count,Count).
contarlista([_|L],Count,Total):- Newcount is Count+1, contarlista(L,Newcount,Total).

getSomeDoc([FD|_],Id,FD):-getId(FD,Id),!,true.
getSomeDoc([_|LD],Id,FD):-getSomeDoc(LD,Id,FD).

% dominio: lista documentos(list), IdDoc(int), Docreemplazo(Doc), lista
% documentos modificada
setSomeDoc([],_,_,_):-!.
setSomeDoc([Doc|LD],Id,NewDoc,NewLD):-getId(Doc,Id),!,[NewDoc,LD]=NewLD.
setSomeDoc([Doc|LD],Id,NewDoc,[Doc|NextLD]):-setSomeDoc(LD,Id,NewDoc,NextLD).

% dominio: nueva lista usuarios(list), lista de usuarios presente en
% prdcs(list from prdcs)
captchaUsers([],_).
captchaUsers([FNewUser|NewUsers],UsersFPrdc):-user(FNewUser,"",[],U),existUsername(UsersFPrdc,U),captchaUsers(NewUsers,UsersFPrdc).

%requerimientos===============================
paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2):-user(Username,Password, Fecha, US),getUsersPrdc(Sn1,LU), not(existUsername(LU,US)), setUsersPrdc(Sn1,[US|LU],Sn2).

paradigmaDocsLogin(Sn1, Username, Password, Sn2):-user(Username,Password, [1,2,2020], US) ,getUsersPrdc(Sn1,LU), existUser(LU,US),setLogPrdc(Sn1,Username,Sn2).

paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2):-existlog(Sn1),getDocsPrdc(Sn1,LD),contarlista(LD,0,Largo),getLogPrdc(Sn1,Owner),docsCreate(Nombre,Fecha,Largo,Owner,D0),addContent(D0,Contenido,D1),setDocsPrdc(Sn1,[D1|LD],Sn2).

paradigmaDocsShare(Sn1,DocumentId,ListaPermisos,ListaUsernamesPermitidos,Sn2):-existlog(Sn1),getLogPrdc(Sn1,Logged),getDocsPrdc(Sn1,ListDocs),getSomeDoc(ListDocs,DocumentId,D0),isOwner(D0,Logged),getUsersPrdc(Sn1,ListUsers),captchaUsers(ListaUsernamesPermitidos,ListUsers),getAccesses(D0,Accesses),addMultiplyAccesses(ListaUsernamesPermitidos,ListaPermisos,Accesses,NewAccesses),setAccesses(D0,NewAccesses,D1),setSomeDoc(ListDocs,DocumentId,D1,NewListDocs),setDocsPrdc(Sn1,NewListDocs,Sn2).


%testeos========================================
test1(PD4):- date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12,2021, D3), paradigmaDocs("google docs", D1, PD1),paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4).

test2(Accesses):- date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3,12, 2021, D3), paradigmaDocs("google docs", D1, PD1),paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2),paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3),paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4),paradigmaDocsLogin(PD4, "vflores", "hola123", PD5),paradigmaDocsCreate(PD5, D2, "archivo 1", "hola mundo, este es elcontenido de un archivo", PD6),paradigmaDocsCreate(PD6, D2, "archivo1", "hola mundo, este es el contenido de un archivo",PD7),paradigmaDocsShare(PD7,0,["W","R","C"],["crios","alopez"],PD8),paradigmaDocsShare(PD8,0,["W","C"],["alopez"],PDS),getDocsPrdc(PDS,ListD0),getSomeDoc(ListD0,0,D0),getAccesses(D0,Accesses).

test3():-canWhatinDocs(["titulo",[1,2,2020],0,"Owner","contenido",[["vflores",["R","W"]]]],"vflores","R").


test4():-Users = [["alopez", "asdfg", [3, 12, 2021]], ["crios", "qwert", [1, 12, 2021]], ["vflores", "hola123", [1, 12, 2021]]],captchaUsers(["vflores","alopez"],Users).
test5(S):-addMultiplyAccesses(["Rodriguez","pedro","sebastian"],["W"],[["Rodriguez",["C","R","W"]]],S).

