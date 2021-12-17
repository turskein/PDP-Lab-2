%---------------------------------------------------------------------------------
%--------------------------Tda Fecha----------------------------------------------
%---------------------------------------------------------------------------------
%de la forma: Dia(int), mes(int), anio(int)
date(Dia,Mes,Anio,[Dia,Mes,Anio]):- Dia > 0, Dia < 32,Mes > 0 ,Mes < 13, Anio >= 1900, Anio < 2022.

getDay([Dia|_], SDay):- Dia= SDay.
getMonth([_,Mes|_], SMonth):- Mes = SMonth.
getYea([_,_,Anio|_], SYear):- Anio = SYear.










%---------------------------------------------------------------------------------
%--------------------TDA User-----------------------------------------------------
%---------------------------------------------------------------------------------
%de la forma: nombre(string), contrase�a(string), fecha(date),
user(Username, Password, Date, [Username, Password, Date]).

sameUsername([Username1|_],[Username1|_]).

samePassword([_,Pass1|_],[_,Pass1|_]).








%---------------------------------------------------------------------------------
%-----------------TDA Docs--------------------------------------------------------
%---------------------------------------------------------------------------------
% de la forma: nombre(string), fecha creacion(date), id del
% documento(int), lista de versiones(list), lista de accesos(access)

docsCreate(Name, FechaCreacion, Id, Owner,Contenido,[Name, FechaCreacion,Id, Owner,[NewVersion],[]]):-
    version(Contenido,FechaCreacion,0,NewVersion).

restoreVersionDocs(Doc,IdVersion,DocSalida):-
    getContent(Doc,VersionesDoc),
    contarlista(VersionesDoc,0,NewID),
    nth0(IdVersion,VersionesDoc,LFVersion),
    setIdVersion(LFVersion,NewID,NewVersion),
    append(VersionesDoc,[NewVersion],NewListVersions),
    setContent(Doc,NewListVersions,DocSalida).

addContent(DocEntrada,Fecha,NewContent,DocSalida):-
    getContent(DocEntrada,VersionesDoc),
    contarlista(VersionesDoc,0,LargoVersiones),
    nth1(LargoVersiones,VersionesDoc,LastVersion),
    getContenidoVrsn(LastVersion,ContenidoLastVersion),
    string_concat(ContenidoLastVersion,NewContent,NewContentofVrsn),
    version(NewContentofVrsn,Fecha,LargoVersiones,NewVersion),
    append(VersionesDoc,[NewVersion],NewVersions),
    setContent(DocEntrada,NewVersions,DocSalida).

getId([_,_,Id|_],Id).
getContent([_,_,_,_,Content,_|_],Content).
getAccesses([_,_,_,_,_,Accesses], Accesses).

setContent([Name, FechaCreacion,Id, Owner,_,Accesses|_],NewContents,[Name, FechaCreacion,Id, Owner,NewContents,Accesses]).

setAccesses([Name, FechaCreacion,Id, Owner,Content,_|_],NewAccesses,[Name, FechaCreacion,Id, Owner,Content,NewAccesses]).

isOwner([_,_,_,Owner|_],Owner).

canWhatinDocs([_,_,_,Owner|_],Owner,_):-!,true.
canWhatinDocs([_,_,_,_,_,LA|_],Name,Letter):-
    getAccessSomeUser(LA,Name,SAC),
    getListAccessUser(SAC,LAU),
    canWhat(LAU,Letter).

%lista de accesos(list from docs), Name(string)
getAccessSomeUser([],_,_):-!,fail.
getAccessSomeUser([FAU|_],Name,AFU):- getNameAccess(FAU,Name), FAU = AFU.
getAcessSomeUser([_|LAU],Name,AFU):- getAcessSomeUser(LAU,Name,AFU).

% dominio: lista de accesos del doc(list accessess from doc), acceso a
% agregar (access)
addOneAccess([],Access,[Access]).
addOneAccess([LastAccess|NextAccesses],Access,[Access|NextAccesses]):-
    getNameAccess(LastAccess,Name1),
    getNameAccess(Access,Name1),!.
addOneAccess([LastAccess|NextAccess],Access,[LastAccess|Accesses]):-addOneAccess(NextAccess,Access,Accesses).

% dominio: lista nombres usuarios(list usernames), lista permisos(list),
% lista de accesos del documento(list access from doc)
addMultiplyAccesses([],_,OldAccesses,OldAccesses):-!.
addMultiplyAccesses([LastUsername|NextUsernames],Permissions,OldAccesses,NewAccesses):-
    addMultiplyAccesses(NextUsernames,Permissions,OldAccesses,NextNew),
    access(LastUsername,Permissions,A),
    addOneAccess(NextNew,A,NewAccesses).





%---------------------------------------------------------------------------------
%-----------TDA Version-----------------------------------------------------------
%---------------------------------------------------------------------------------

%de la forma: contenido("string"), fecha de creación(date), id versión (int), Salida
version(Contenido,Date,Id,[Contenido,Date,Id]).

getContenidoVrsn([Contenido|_],Contenido).

setIdVersion([Contenido,Date,_],NewId,[Contenido,Date,NewId]).






%---------------------------------------------------------------------------------
%-----------TDA Access------------------------------------------------------------
%---------------------------------------------------------------------------------

% de la forma: nombre usuario(string), lista de accesos del user(list)
access(Name,LA,[Name,LA]).

getNameAccess([Name|_],Name).
getListAccessUser([_,LA|_],LA).

% lista de accesos del user(list from access), tipo de acceso a
% buscar(CHAR)
canWhat([],_):- !,fail.
canWhat([FA|_],FA):- !, true.
canWhat([_|LAU],Letter):-canWhat(LAU,Letter).













/*---------------------------------------------------------------------------------
------------Tda Paradigmadocs----------------------------------------------------
---------------------------------------------------------------------------------
 de la forma: nombre de la plataforma(string), fecha de creacion(date),
 usuario activo(string), usuarios registrados(list), documentos(list).*/

paradigmaDocs(Name, Date, [Name, Date, "", [],[]]).



setUsersPrdc([Name,Date,Log,_,Docs|_],NewUsers,[Name,Date,Log,NewUsers,Docs]).

setLogPrdc([Name,Date,_,Users,Docs|_],NewLog,[Name,Date,NewLog,Users,Docs]).

setDocsPrdc([Name,Date,Log,Users,_|_],NewDocs,[Name,Date,Log,Users,NewDocs]).

getUsersPrdc([_,_,_,Users,_|_],Users).

getLogPrdc([_,_,Log,_,_|_],Log).

getDocsPrdc([_,_,_,_,Docs|_],Docs).

existlog(Sn):-not(getLogPrdc(Sn,"")).

closelog([Name,Date,_,Users,Docs|_],[Name,Date,"",Users,Docs]).

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
captchaUsers([FNewUser|NewUsers],UsersFPrdc):-
    user(FNewUser,"",[],U),
    existUsername(UsersFPrdc,U),
    captchaUsers(NewUsers,UsersFPrdc).












%---------------------------------------------------------------------------------
%------------------------------------requerimientos-------------------------------
%---------------------------------------------------------------------------------

paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2):-
    user(Username,Password, Fecha, US),
    getUsersPrdc(Sn1,LU),
    not(existUsername(LU,US)),
    setUsersPrdc(Sn1,[US|LU],Sn2).

paradigmaDocsLogin(Sn1, Username, Password, Sn2):-
    user(Username,Password, [1,2,2020], US),
    getUsersPrdc(Sn1,LU),
    existUser(LU,US),
    setLogPrdc(Sn1,Username,Sn2).

paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2):-
    existlog(Sn1),
    getDocsPrdc(Sn1,LD),
    contarlista(LD,0,Largo),
    getLogPrdc(Sn1,Owner),
    docsCreate(Nombre,Fecha,Largo,Owner,Contenido,D0),
    setDocsPrdc(Sn1,[D0|LD],Sn),
    closelog(Sn,Sn2).

paradigmaDocsShare(Sn1,DocumentId,ListaPermisos,ListaUsernamesPermitidos,Sn2):-
    existlog(Sn1),
    getLogPrdc(Sn1,Logged),
    getDocsPrdc(Sn1,ListDocs),
    getSomeDoc(ListDocs,DocumentId,D0),
    isOwner(D0,Logged),
    getUsersPrdc(Sn1,ListUsers),
    captchaUsers(ListaUsernamesPermitidos,ListUsers),
    getAccesses(D0,Accesses),
    addMultiplyAccesses(ListaUsernamesPermitidos,ListaPermisos,Accesses,NewAccesses),
    setAccesses(D0,NewAccesses,D1),
    setSomeDoc(ListDocs,DocumentId,D1,NewListDocs),
    setDocsPrdc(Sn1,NewListDocs,Sn),
    closelog(Sn,Sn2).

paradigmaDocsAdd(Sn1, DocumentId, Date, ContenidoTexto, Sn2):-
    getDocsPrdc(Sn1,ListDocs),
    getSomeDoc(ListDocs,DocumentId,TheDocument),
    getLogPrdc(Sn1,Logged),
    canWhatinDocs(TheDocument,Logged,"W"),
    addContent(TheDocument,Date,ContenidoTexto,NewDocument),
    setSomeDoc(ListDocs,DocumentId,NewDocument,NewListDocs),
    setDocsPrdc(Sn1,NewListDocs,NewPrdcs),
    closelog(NewPrdcs,Sn2).

paradigmaDocsRestoreVersion(Sn1, DocumentId, IdVersion, Sn2):-
    getDocsPrdc(Sn1,ListDocs),
    getSomeDoc(ListDocs,DocumentId,TheDocument),
    getLogPrdc(Sn1,Logged),
    isOwner(TheDocument,Logged),
    restoreVersionDocs(TheDocument,IdVersion,NewDocument),
    setSomeDoc(ListDocs,DocumentId,NewDocument,NewListDocs),
    setDocsPrdc(Sn1,NewListDocs,Sn),
    closelog(Sn,Sn2).

%---------------------------------------------------------------------------------
%-----------------------------------testeos---------------------------------------
%---------------------------------------------------------------------------------

test1(PD4):- 
    date(20, 12, 2015, D1),
    date(1, 12, 2021, D2), date(3, 12,2021, D3),
    paradigmaDocs("google docs", D1, PD1),
    paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2),
    paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3),
    paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4).

test2():- 
    date(20, 12, 2015, D1),
    date(1, 12, 2021, D2), date(3,12, 2021, D3), 
    paradigmaDocs("google docs", D1, PD1),
    paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2),
    paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3),
    paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4),
    paradigmaDocsLogin(PD4, "vflores", "hola123", PD5),
    paradigmaDocsCreate(PD5, D2, "archivo 1", "hola mundo, este es elcontenido de un archivo", PDK),
    paradigmaDocsLogin(PDK, "vflores", "hola123", PD7),
    paradigmaDocsShare(PD7,0,["W","R"],["crios","alopez"],PD8),
    paradigmaDocsLogin(PD8, "vflores", "hola123", PD9),
    paradigmaDocsShare(PD9,0,["W"],["alopez"],PD10),
    paradigmaDocsLogin(PD10, "vflores", "hola123", PD11),
    paradigmaDocsAdd(PD11, 0, D1, " este es un nuevo texto", PD12),
    paradigmaDocsLogin(PD12, "vflores", "hola123", PD13),
    paradigmaDocsRestoreVersion(PD13,0,0,PD14).

test3():-canWhatinDocs(["titulo",[1,2,2020],0,"Owner","contenido",[["vflores",["R","W"]]]],"vflores","R").


test4():-
    Users = [["alopez", "asdfg", [3, 12, 2021]],["crios", "qwert", [1, 12, 2021]],["vflores", "hola123", [1, 12, 2021]]],
    captchaUsers(["vflores","alopez"],Users).
test5(S):-
    addMultiplyAccesses(["Rodriguez","pedro","sebastian"],["W"],[["Rodriguez",["C","R","W"]]],S).

