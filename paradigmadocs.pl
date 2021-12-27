%---------------------------------------------------------------------------------
%--------------------------Tda Fecha----------------------------------------------
%---------------------------------------------------------------------------------

/*
======Dominios======
Dia     : Entero   
Mes     : Entero
Anio    : Entero
Date    : Fecha
StrFecha: String
=====Predicados=====
date(Dia,Mes,Anio,Fecha)
getDay(Fecha,Dia)
getMonth(Fecha,Mes)
getYea(Fecha,Anio)
dateToString(Fecha,StrFecha)
========Metas=======
--Primarias--
getDay
getMonth
getYea
--secundarias--
date
dateToString
=====Clausulas=====
Reglas
*/
%de la forma: Dia(int), mes(int), anio(int)
date(Dia,Mes,Anio,[Dia,Mes,Anio]):- Dia > 0, Dia < 32,Mes > 0 ,Mes < 13, Anio >= 1900, Anio < 2022.

getDay([Dia|_], SDay):- Dia= SDay.
getMonth([_,Mes|_], SMonth):- Mes = SMonth.
getYea([_,_,Anio|_], SYear):- Anio = SYear.

dateToString(Date,StrOut):-
    getDay(Date,Day),
    number_string(Day,StrDay),
    getMonth(Date,Month),
    number_string(Month,StrMonth),
    getYea(Date,Year),
    number_string(Year,StrYear),
    string_concat(StrDay,"-",D),
    string_concat(StrMonth,"-",M),
    string_concat(M,StrYear,Y),
    string_concat(D,Y,StrOut).

%---------------------------------------------------------------------------------
%--------------------TDA User-----------------------------------------------------
%---------------------------------------------------------------------------------
/*
======Dominios======
Username    : String
Pass        : String
Date        : Fecha
StrOut      : String
NuevoUsuario: User
=====Predicados=====
user(Username,Pass,Date,NuevoUsuario)
getUsernameUser(User, Username)
getPassUser(User, Username)
getDateUser(User, Date)
sameUsername(User, User)
samePassword(User, User)
userToString(User, StrOut)
========Metas=======
--Primarias
getUsername
getPassuser
getDateUser
--secundarias
user
userToString
sameUsername
samePassword
=====Clausulas=====
Reglas
*/
%de la forma: nombre(string), contrase�a(string), fecha(date),
user(Username, Pass, Date, [Username, Pass, Date]).

getUsernameUser([Username|_],Username).
getPassUser([_,Pass|_],Pass).
getDateUser([_,_,Date],Date).

sameUsername([Username1|_],[Username1|_]).

samePassword([_,Pass1|_],[_,Pass1|_]).

userToString(User,StrOut):-
    getUsernameUser(User, Username),
    getPassUser(User, Pass),
    getDateUser(User, Date),
    dateToString(Date,StrDate),
    string_concat("Username: ", Username,LineUser),
    string_concat(LineUser,"\n",LineUserW),
    string_concat("Password: ", Pass,LinePass),
    string_concat(LinePass,"\n",LinePassW),
    string_concat("Fecha de creacion: ",StrDate,LineDate),
    string_concat(LineDate,"\n", LineDateW),
    string_concat(LineUserW,LinePassW,A),
    string_concat(A,LineDateW,StrOut).









%---------------------------------------------------------------------------------
%-----------------TDA Docs--------------------------------------------------------
%---------------------------------------------------------------------------------
/*
======Dominios======
Doc         : Doc
NewDoc      : Doc
Id          : Entero
Title       : String
Date        : Fecha
Versions    : Lista de versiones
Access      : Acceso
Accesses    : Lista de accesos
Version     : Version
Contenido   : String
Permissions : lista de tipos de permiso
OldAccesses : lista de accesos
NewAccesses : lista de accesos
StrOut      : string
Letter      : string
NumberOfCharacters : Integer
SearchText  : string
ReplaceText : string
=====Predicados=====
getId(Doc, Id)
getTitle(Doc, Title)
getCreation(Doc, Date)
getOwnerDoc(Doc, Owner)
getContentDoc(Doc, Versions)
getAccessesDoc(Doc, Accesses)
setVersionsDoc(Doc,Version,NewDoc)
setAccessesDoc(Doc,Accesses,NewDoc)
isOwner(Doc, Owner)
docsCreate(Name, Date, Id, Owner, Contenido, Doc)
restoreVersionDocs(Doc, Id, NewDoc)
addContent(Doc, Date, Content, NewDoc)
canWhatinDocs(Doc, Letter)
getAccessSomeUser(Accesses, Name, AccessUser)
addOneAccess(Accesses, Access, NewAccesses)
addMultiplyAccesses(Accesses, Permissions, OldAccesses, NewAccesses)
showDoc(Doc, Name, StrOut)
showLastVersion(Versions, StrOut)
showEveryVersion(Versions, StrOut)
showOneAccess(Accesses, StrOut)
showEveryAccess(Accesses, StrOut)
showAllInformationDoc(Doc, StrOut)
showDocForOwner(Doc, StrOut)
showDocForInvited(Doc, Name, StrOut)
revokeAccessesDoc(Doc, NewDoc)
searchOnVersions(Versions,Contenido)
searchContentOnDoc(Doc,Contenido)
deleteOnDocs(Doc, Date, NumberOfCharacters, NewDoc)
searchAndReplaceOnDocs(Doc, SearchText, ReplaceText, NewDoc)
========Metas=======
--Primarias--
showLastVersion
showEveryVersion
showOneAccess
showEveryAccess
showAllInformationDoc
showDocForOwner
showDocForInvited
addOneAccess
getAccessSomeUser
canWhatinDocs
isOwner
getId
getTitle
getCreation
getOwnerDoc
getContentDoc
getAccessesDoc
setVersionsDoc
setAccessesDoc
searchOnVersions
--secundarias--
deleteOnDocs
searchAndReplaceOnDocs
searchContentOnDoc
revokeAccessesDoc
showDoc
addMultiplyAccesses
addContent
restoreVersionDocs
docsCreate
=====Clausulas=====
Reglas
*/
% de la forma: nombre(string), fecha creacion(date), id del
% documento(int), lista de versiones(list), lista de accesos(access)

docsCreate(Name, Date, Id, Owner, Contenido,[Name, Date,Id, Owner,[NewVersion],[]]):-
    version(Contenido,Date,0,NewVersion).

restoreVersionDocs(Doc,IdVersion,DocSalida):-
    getContentDoc(Doc,VersionesDoc),
    contarlista(VersionesDoc,0,NewID),
    nth0(IdVersion,VersionesDoc,LFVersion),
    setIdVersion(LFVersion,NewID,NewVersion),
    append(VersionesDoc,[NewVersion],NewListVersions),
    setVersionsDoc(Doc,NewListVersions,DocSalida).

addContent(DocEntrada,Date,NewContent,DocSalida):-
    getContentDoc(DocEntrada,VersionesDoc),
    contarlista(VersionesDoc,0,LargoVersiones),
    nth1(LargoVersiones,VersionesDoc,LastVersion),
    getContenidoVrsn(LastVersion,ContenidoLastVersion),
    string_concat(ContenidoLastVersion,NewContent,NewContentofVrsn),
    version(NewContentofVrsn,Date,LargoVersiones,NewVersion),
    append(VersionesDoc,[NewVersion],NewVersions),
    setVersionsDoc(DocEntrada,NewVersions,DocSalida).

getId([_,_,Id|_],Id).
getTitle([Title|_],Title).
getCreation([_,Creation|_],Creation).
getOwnerDoc([_,_,_,Owner|_],Owner).
getContentDoc([_,_,_,_,Content,_|_],Content).
getAccessesDoc([_,_,_,_,_,Accesses], Accesses).

setVersionsDoc([Name, Date,Id, Owner,_,Accesses|_],NewVersions,[Name, Date,Id, Owner,NewVersions,Accesses]).
setAccessesDoc([Name, Date,Id, Owner,Versions,_|_],NewAccesses,[Name, Date,Id, Owner,Versions,NewAccesses]).
isOwner([_,_,_,Owner|_],Owner).

canWhatinDocs([_,_,_,Owner|_],Owner,_):-!,true.
canWhatinDocs([_,_,_,_,_,ListAccesses|_],Name,Letter):-
    getAccessSomeUser(ListAccesses,Name,SomeAccess),
    getListAccessUser(SomeAccess,ListAccessUser),
    canWhat(ListAccessUser,Letter).

%lista de accesos(list from docs), Name(string)
getAccessSomeUser([FirstAccess|_],Name,FirstAccess):- getNameAccess(FirstAccess,Name),!.
getAccessSomeUser([_|NextAccesses],Name,AccessUser):- getAccessSomeUser(NextAccesses,Name,AccessUser).

% dominio: lista de accesos del doc(list accessess from doc), acceso a
% agregar (access)
addOneAccess([],Access,[Access]).
addOneAccess([LastAccess|NextAccesses],Access,[Access|NextAccesses]):-
    getNameAccess(LastAccess,Name1),
    getNameAccess(Access,Name1),!.
addOneAccess([LastAccess|NextAccess],Access,[LastAccess|Accesses]):-
    addOneAccess(NextAccess,Access,Accesses).

% dominio: lista nombres usuarios(list usernames), lista permisos(list),
% lista de accesos del documento(list access from doc)
addMultiplyAccesses([],_,OldAccesses,OldAccesses):-!.
addMultiplyAccesses([LastUsername|NextUsernames],Permissions,OldAccesses,NewAccesses):-
    addMultiplyAccesses(NextUsernames,Permissions,OldAccesses,NextNew),
    access(LastUsername,Permissions,A),
    addOneAccess(NextNew,A,NewAccesses).

%descripción: validará StrOut como la muestra del documento señalado,
% de acuerdo al tipo de permiso que tiene el usuario
%dominio: doc(documento a decidir cómo mostrar), nombre de usuario(string), string de salida
showDoc(Documento, User, StrOut):-
    isOwner(Documento,User),
    showDocForOwner(Documento,StrOut),
    !.
showDoc(Documento,User,StrOut):-
    canWhatinDocs(Documento,User,"R"),
    !,
    showDocForInvited(Documento,User,StrOut).
showDoc(Documento,"",StrOut):-
    showAllInformationDoc(Documento,StrOut).
showDoc(_,_,"").

%descripción: retorna el contenido de la última versión del doc
%dominio: lista de versiones(list versions from docs), str
showLastVersion(ListVersions,StrOut):-
    contarlista(ListVersions,0,Largo),
    nth1(Largo,ListVersions,TheLastVersion),
    versionToString(TheLastVersion,StrVersion),
    string_concat(StrVersion,"\n",StrOut).

%descripción: retorna el contenido de todas las versiones de una lista de versiones
%dominio: lista de versiones(list versions from docs), str
showEveryVersion([],"").
showEveryVersion([Head|Next],StrOut):-
    showEveryVersion(Next,StrAnother),
    versionToString(Head,StrVersion),
    string_concat(StrVersion,"\n",WithJump),
    string_concat(StrAnother,WithJump,StrOut).

%descripción: retorna como string el contenido de un acceso en particular
%dominio: lista de accesos (list access from docs), nombre de usuario(str),string de salida
showOneAccess([Head|_],User,StrOut):-
    getNameAccess(Head,User),
    !,
    accessToString(Head,StrOut).
showOneAccess([_|NextAccess],User,StrOut):-
    showOneAccess(NextAccess,User,StrOut).


%descripción: retorna como string el contenido de todos los  accesos del documento
%dominio: lista de accesos (list access from docs), string de salida
showEveryAccess([],"").
showEveryAccess([Head|Next],StrOut):- 
    showEveryAccess(Next,Out),
    string_concat(Out,"\n",WithJump),
    accessToString(Head,StrAccess),
    string_concat(WithJump,StrAccess,StrOut).

%descripción: retorna como string todo el contenido de un documento
%dominio: doc(documen a mostrar), string de sálida
showAllInformationDoc(Documento,StrOut):-
    getTitle(Documento,Title),%=============Title
    getCreation(Documento,DateCreation),
    dateToString(DateCreation,StrDate),%=============StrDate
    getId(Documento, Id),
    number_string(Id, StrId),
    string_concat("Id: ",StrId, BId),
    string_concat(BId,"\n",BLockId),
    getContentDoc(Documento,Versions),
    showEveryVersion(Versions,StrVersions),%=============StrVersions
    getAccessesDoc(Documento, Accesses),
    getOwnerDoc(Documento,Owner),
    string_concat("Creador: ",Owner,StrOwner),
    string_concat(StrOwner,"\n",StrOwnerW),
    showEveryAccess(Accesses,StrAccess), %=============StrAccess
    string_concat("======",Title,Half),
    string_concat(Half,"======",TheTitle),
    string_concat(TheTitle,"\n",TheTitleW),
    string_concat("Fecha de creacion: ",StrDate,TheDate),
    string_concat(TheDate,"\n",TheDateW),
    string_concat("---Versions---\n",StrVersions,BlockVersions),
    string_concat("---Accesses---",StrAccess,BlockAccesses),
    string_concat(TheTitleW,TheDateW,A),
    string_concat(A,StrOwnerW,N),
    string_concat(N,BLockId,K),
    string_concat(K,BlockVersions,B),
    string_concat(B,BlockAccesses,C),
    string_concat(C,"\n",StrOut).

%descripción: retorna como string todo el contenido de un documento
%dominio: doc(documen a mostrar), string de sálida
showDocForOwner(Documento,StrOut):-
    getTitle(Documento,Title),%=============Title
    getCreation(Documento,DateCreation),
    dateToString(DateCreation,StrDate),%=============StrDate
    getContentDoc(Documento,Versions),
    showEveryVersion(Versions,StrVersions),%=============StrVersions
    getAccessesDoc(Documento, Accesses),
    string_concat("Creador: Propio","\n",StrOwnerW),
    showEveryAccess(Accesses,StrAccess), %=============StrAccess
    string_concat("======",Title,Half),
    string_concat(Half,"======",TheTitle),
    string_concat(TheTitle,"\n",TheTitleW),
    string_concat("Fecha de creacion: ",StrDate,TheDate),
    string_concat(TheDate,"\n",TheDateW),
    string_concat("---Versions---\n",StrVersions,BlockVersions),
    string_concat("---Accesses---",StrAccess,BlockAccesses),
    string_concat(TheTitleW,TheDateW,A),
    string_concat(A,StrOwnerW,N),
    string_concat(N,BlockVersions,B),
    string_concat(B,BlockAccesses,C),
    string_concat(C,"\n",StrOut).

showDocForInvited(Documento, User, StrOut):-
    getTitle(Documento,Title),
    getAccessesDoc(Documento, Accesses),
    getContentDoc(Documento,ContenidoDoc),
    showOneAccess(Accesses, User, TheAccess),
    showLastVersion(ContenidoDoc, LastVersion),
    string_concat("======",Title,Half),
    string_concat(Half,"======",TheTitle),
    string_concat(TheTitle,"\n",TheTitleW),
    string_concat("---Versions---\n",LastVersion,BlockVersions),
    string_concat("---Accesses---\n",TheAccess,BlockAccesses),
    string_concat(TheTitleW,"",A),
    string_concat(A,BlockVersions,B),
    string_concat(B,BlockAccesses,C),
    string_concat(C,"\n",StrOut).
    
revokeAccessesDoc(Documento, NewDocument):-
    setAccessesDoc(Documento,[],NewDocument).

searchContentOnDoc(Doc,ContentLF):-
    getContentDoc(Doc,Versions),
    searchOnVersions(Versions,ContentLF).

searchOnVersions([FirsVersion|_],ContentLF):-
    existContentinVersion(FirsVersion,ContentLF),!.
searchOnVersions([_,NextVersions],ContentLF):-
    searchOnVersions(NextVersions,ContentLF).

deleteOnDocs(Doc, Date, NumberOfCharacters, NewDoc):-
    getContentDoc(Doc, Versions),
    contarlista(Versions, 0, Largo),
    nth1(Largo, Versions, TheVersion),
    getContenidoVrsn(TheVersion, ContenidoVersion),
    string_length(ContenidoVersion, LargoContenido),
    NumberOfCharacters < LargoContenido,
    NewLargoContenido is LargoContenido - NumberOfCharacters,
    substring(ContenidoVersion, 1, NewLargoContenido, NuevoContenidoVersion),
    version(NuevoContenidoVersion, Date, Largo, NewVersion),
    append(Versions, [NewVersion], NewVersions),
    setVersionsDoc(Doc, NewVersions, NewDoc),!.
deleteOnDocs(Doc, Date, NumberOfCharacters, NewDoc):-
    getContentDoc(Doc, Versions),
    contarlista(Versions, 0, Largo),
    nth1(Largo, Versions, TheVersion),
    getContenidoVrsn(TheVersion, ContenidoVersion),
    string_length(ContenidoVersion, LargoContenido),
    NumberOfCharacters >= LargoContenido,
    version("", Date, Largo, NewVersion),
    append(Versions, [NewVersion], NewVersions),
    setVersionsDoc(Doc, NewVersions, NewDoc).

searchAndReplaceOnDocs(Doc, SearchText, ReplaceText, NewDoc):-
    getContentDoc(Doc, Versions),
    contarlista(Versions, 0, Largo),
    nth1(Largo, Versions, TheVersion),
    existContentinVersion(TheVersion, SearchText),
    getContenidoVrsn(TheVersion, ContenidoVersion),
    re_replace(SearchText, ReplaceText, ContenidoVersion, NewContenido),
    getDateVrsn(TheVersion, Date),
    version(NewContenido, Date, Largo, NewVersion),
    append(Versions, [NewVersion], NewVersions),
    setVersionsDoc(Doc, NewVersions, NewDoc),!.
searchAndReplaceOnDocs(Doc,_, _, Doc).

%---------------------------------------------------------------------------------
%-----------TDA Version-----------------------------------------------------------
%---------------------------------------------------------------------------------
/*
======Dominios======
Contenido   : String
Date        : Fecha
Id          : Entero
NewId       : Entero
Version     : Version
NewVersion  : Version
StrOut      : String
=====Predicados=====
version(Contenido, Date, Id, Version)
getContenidoVrsn(Version, Contenido)
getDateVrsn(Version, Date)
getIdVrsn(Version, Id)
setIdVersion(Version,NewId, NewVersion)
versionToString(Version, StrOut)
existContentinVersion(Version,Contenido)
========Metas=======
--Primarias--
getContenidoVrsn
getDateVrsn
getIdVrsn
--secundarias--
existContentinVersion
version
setIdVersion
versionToString
=====Clausulas=====
Reglas
*/
%de la forma: contenido("string"), fecha de creación(date), id versión (int), Salida
version(Contenido,Date,Id,[Contenido,Date,Id]).

getContenidoVrsn([Contenido|_],Contenido).
getDateVrsn([_,Date|_],Date).
getIdVrsn([_,_,Id|_],Id).

setIdVersion([Contenido,Date,_],NewId,[Contenido,Date,NewId]).

versionToString(Version,StrOut):-
    getContenidoVrsn(Version,ContentVrsn),
    getDateVrsn(Version,Date),
    dateToString(Date,StrDate),
    getIdVrsn(Version,Id),
    number_string(Id,StrId),
    string_concat("Contenido: ",ContentVrsn,A),
    string_concat(A,"\n",B),
    string_concat("Fecha: ",StrDate,F),
    string_concat(F,"\n",G),
    string_concat("Id: ", StrId, I),
    string_concat(I,"\n",J),
    string_concat(B,G,M),
    string_concat(M,J,StrOut).

existContentinVersion(Version,ContentLF):-
    getContenidoVrsn(Version,Contenido),
    existSubStr(Contenido,ContentLF).

existSubStr(BigWord,LfWord):-
    string_length(LfWord,Largo),
    searchword(BigWord,LfWord,1,Largo).

searchword(BigWord,LfWord,FirstNumber,FinalNumber):-
    substring(BigWord,FirstNumber,FinalNumber,LfWord),!.
searchword(BigWord,LfWord,FirstNumber,FinalNumber):-
    string_length(BigWord,Largo),
    substring(BigWord,2,Largo,NewBigWord),
    searchword(NewBigWord,LfWord,FirstNumber,FinalNumber).

%---------------------------------------------------------------------------------
%-----------TDA Access------------------------------------------------------------
%---------------------------------------------------------------------------------
/*
======Dominios======
Name        : String
Access      : Access
ListKindAccess: lista de tipos de permisos
Letter      : String
ListAccess  : Lista de accesos
StrOut      : String
=====Predicados=====
access(Name,ListKindAccess,Access)
getNameAccess(Access, Name)
getListAccessUser(Access, ListKindAccess)
canWhat(ListKindAccess, Letter)
listAccessToString(ListAccess,StrOut)
accessToString(Access, StrOut)
========Metas=======
--Primarias--
getNameAccess
getListAccessUser
--secundarias--
access
canWhat
listAccessToString
accessToString
=====Clausulas=====
Reglas
*/
% de la forma: nombre usuario(string), lista de accesos del user(list)
access(Name,ListKindAccess,[Name,ListKindAccess]).

getNameAccess([Name|_],Name).
getListAccessUser([_,ListKindAccess|_],ListKindAccess).

% lista de accesos del user(list from access), tipo de acceso a
% buscar(CHAR)
canWhat([],_):- !,fail.
canWhat([FirstAccess|_],FirstAccess):- !, true.
canWhat([_|NextKindAccess],Letter):-canWhat(NextKindAccess,Letter).

% descripción: muestra los tipos de accesos que presenta una lista de 
% accesos perteneciente a un acceso en particular
%dominio: lista de tipos de acceso(list kind of access from access), string
listAccessToString([],"").
listAccessToString([Head|Next],StrOut):-
    listAccessToString(Next,Out),
    string_concat(Out,"-",XD),
    string_concat(XD,Head,StrOut).

accessToString(Access,StrOut):-
    getNameAccess(Access,Name),
    getListAccessUser(Access,ListAccesses),
    listAccessToString(ListAccesses, StrListAccesses),
    string_concat("Nombre: ",Name, N),
    string_concat(N,"\n",K),
    string_concat("Tipos de accesos: ",StrListAccesses,A),
    string_concat(A,"\n",B),
    string_concat(K,B,StrOut).

/*---------------------------------------------------------------------------------
------------Tda Paradigmadocs----------------------------------------------------
---------------------------------------------------------------------------------
 */
 /*
======Dominios======
Prdc        : Paradigmadocs
NewPrdc     : Paradigmadocs
Users       : Lista de usuarios
Docs        : Lista de documentos
NewDocs     : Lista de documentos
Name        : String
Date        : Fecha
Log         : String
Usernames   : Lista de nombre de usuarios
ListId's    : lista de id's de documentos
StrOut      : String

=====Predicados=====
setUsersPrdc(Prdc,Users,NewPrdc)
setLogPrdc(Prdc,Log,NewPrdc)
setDocsPrdc(Prdc,Docs,NewPrdc)
getNamePrdc(Prdc,Name)
getDatePrdc(Prdc,Date)
getUsersPrdc(Prdc,Users)
getLogPrdc(Prdo,Log)
getDocsPrdc(Prdc,Docs)
existlog(Prdc)
closelog(Prdc,NewPrdc)
existUsername(Users,User)
existUser(Users,User)
getSomeDoc(Docs, Id, Doc)
setSomeDoc(Docs,Id,Doc,NewDocs)
captchaUsers(Users,Usernames)
showEveryDoc(Docs,StrOut)
showEveryUser(Users,StrOut)
revokeAccessesifOwner(Docs, Name, Id, NewDocs)
revokemultiplyAccesesifOwner(ListId's, Name, Docs, NewDocs)
revokeAccessesAllDocsifOwner(Name, OldDocs, NewDocs)
========Metas=======
--Primarias--
revokeAccessesifOwner
existUsername
--secundarias--
setUsersPrdc
setLogPrdc
setDocsPrdc
getNamePrdc
getDatePrdc
getUsersPrdc
getLogPrdc
getDocsPrdc
existlog
closelog
existUser
getSomeDoc
setSomeDoc
captchaUsers
showEveryDoc
showEveryUser
revokemultiplyAccesesifOwner
revokeAccessesAllDocsifOwner
=====Clausulas=====
Reglas
*/
%de la forma: nombre de la plataforma(string), fecha de creacion(date),
%usuario activo(string), usuarios registrados(list), documentos(list).

setUsersPrdc([Name,Date,Log,_,Docs|_],NewUsers,[Name,Date,Log,NewUsers,Docs]).
setLogPrdc([Name,Date,_,Users,Docs|_],NewLog,[Name,Date,NewLog,Users,Docs]).
setDocsPrdc([Name,Date,Log,Users,_|_],NewDocs,[Name,Date,Log,Users,NewDocs]).
getNamePrdc([Name|_],Name).
getDatePrdc([_,Date|_],Date).
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

showEveryDoc([],_, "").
showEveryDoc([FirstDoc|NextDocs],User,StrOut):-
    showEveryDoc(NextDocs,User,OutNextDocs),
    showDoc(FirstDoc, User, StrFirstDoc),
    string_concat(StrFirstDoc,OutNextDocs,StrOut).

showEveryUser([],_,"").
showEveryUser([FirstUser|NextUsers],"",StrOut):-
    showEveryUser(NextUsers,"",OutNextUsers),
    string_concat(OutNextUsers,"\n",W),
    userToString(FirstUser,StrUser),
    string_concat(W,StrUser,StrOut).
showEveryUser([FirstUser|_],Username,StrOut):-
    getUsernameUser(FirstUser,Username),
    userToString(FirstUser,StrOut).
showEveryUser([_|NextUsers],Username,StrOut):-
    showEveryUser(NextUsers,Username,StrOut).

%dominio: list Docs, User, IdDoc, New list of docs
revokeAccessesifOwner([FirstDoc|NextDocs], User, Id,[NewDoc|NextDocs]):-
    getId(FirstDoc,Id),
    isOwner(FirstDoc, User),
    revokeAccessesDoc(FirstDoc,NewDoc),!.
revokeAccessesifOwner([FirstDoc|NextDocs],User,Id,[FirstDoc|NewDocs]):-
    revokeAccessesifOwner(NextDocs,User,Id,NewDocs).

%dominio: list Docs, User, list of id's Docs, New list of docs
revokemultiplyAccesesifOwner([],_, OldDocs,OldDocs).
revokemultiplyAccesesifOwner([FirstId|NextIds], User, OldDocs,NewDocs):-
    revokeAccessesifOwner(OldDocs, User,FirstId,BeforesNewDocs),
    revokemultiplyAccesesifOwner(NextIds, User, BeforesNewDocs,NewDocs).

revokeAccessesAllDocsifOwner(_,[],[]).
revokeAccessesAllDocsifOwner(User,[FirstDoc|NextDocs],[NewDoc|BeforeNextDocs]):-
    isOwner(FirstDoc,User),
    revokeAccessesDoc(FirstDoc,NewDoc),
    revokeAccessesAllDocsifOwner(User, NextDocs, BeforeNextDocs).
revokeAccessesAllDocsifOwner(User,[FirstDoc|NextDocs],[FirstDoc|BeforeNextDocs]):-
    revokeAccessesAllDocsifOwner(User, NextDocs, BeforeNextDocs).

searchContentOnDocs([],_,_,[]).
searchContentOnDocs([FirstDoc|NextDocs],User,Contenido,[FirstDoc|DocsEncontrados]):-
    canWhatinDocs(FirstDoc,User,"R"),
    searchContentOnDoc(FirstDoc,Contenido),
    searchContentOnDocs(NextDocs,User,Contenido,DocsEncontrados),!.
searchContentOnDocs([_|NextDocs],User,Contenido,DocsEncontrados):-
    searchContentOnDocs(NextDocs,User,Contenido,DocsEncontrados).
    

%---------------------------------------------------------------------------------
%------------------------------------requerimientos-------------------------------
%---------------------------------------------------------------------------------
paradigmaDocs(Name, Date, [Name, Date, "", [],[]]).

paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2):-
    user(Username,Password, Fecha, User),
    getUsersPrdc(Sn1,ListUsers),
    not(existUsername(ListUsers,User)),
    setUsersPrdc(Sn1,[User|ListUsers],Sn2).

paradigmaDocsLogin(Sn1, Username, Password, Sn2):-
    user(Username,Password, [1,2,2020], User),
    getUsersPrdc(Sn1,ListUsers),
    existUser(ListUsers,User),
    setLogPrdc(Sn1,Username,Sn2).

paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2):-
    existlog(Sn1),
    getDocsPrdc(Sn1,ListDocs),
    contarlista(ListDocs,0,Largo),
    getLogPrdc(Sn1,Logged),
    docsCreate(Nombre,Fecha,Largo,Logged,Contenido,Doc0),
    setDocsPrdc(Sn1,[Doc0|ListDocs],Sn),
    closelog(Sn,Sn2).

paradigmaDocsShare(Sn1,DocumentId,ListaPermisos,ListaUsernamesPermitidos,Sn2):-
    existlog(Sn1),
    getLogPrdc(Sn1,Logged),
    getDocsPrdc(Sn1,ListDocs),
    getSomeDoc(ListDocs,DocumentId,Doc0),
    isOwner(Doc0,Logged),
    getUsersPrdc(Sn1,ListUsers),
    captchaUsers(ListaUsernamesPermitidos,ListUsers),
    getAccessesDoc(Doc0,Accesses),
    addMultiplyAccesses(ListaUsernamesPermitidos,ListaPermisos,Accesses,NewAccesses),
    setAccessesDoc(Doc0,NewAccesses,NewDoc),
    setSomeDoc(ListDocs,DocumentId,NewDoc,NewListDocs),
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

paradigmaDocsToString(Sn1, StrOut):-
    existlog(Sn1),
    getUsersPrdc(Sn1,Users),
    getLogPrdc(Sn1,Logged),
    getDocsPrdc(Sn1,Docs),
    showEveryUser(Users, Logged, StrUsers),
    showEveryDoc(Docs,Logged,StrDocs),
    string_concat("#######Users#######\n",StrUsers,BlockUsers),
    string_concat("#######Docs#######\n",StrDocs,BlockDocs),
    string_concat(BlockUsers,BlockDocs,StrOut).

paradigmaDocsToString(Sn1, StrOut):-
    not(existlog(Sn1)),
    getUsersPrdc(Sn1,Users),
    getLogPrdc(Sn1,Logged),
    getDocsPrdc(Sn1,Docs),
    showEveryUser(Users, Logged, StrUsers),
    showEveryDoc(Docs,Logged,StrDocs),
    string_concat("#######Users#######\n",StrUsers,BlockUsers),
    string_concat("#######Docs#######\n",StrDocs,BlockDocs),
    string_concat(BlockUsers,BlockDocs,NextInfor),

    getNamePrdc(Sn1,NamePrdc),
    string_concat("Nombre plataforma: ",NamePrdc,LineName),
    string_concat(LineName,"\n",LineNameW),

    getDatePrdc(Sn1,DatePrdc),
    dateToString(DatePrdc,StrDate),
    string_concat("Fecha creacion plataforma: ", StrDate,LineDate),
    string_concat(LineDate,"\n",LineDateW),
    string_concat(LineNameW,LineDateW,Infor),

    string_concat(Infor,NextInfor,StrOut).

paradigmaDocsRevokeAllAccesses(Sn1, DocumentIds, Sn2):-
    existlog(Sn1),
    not(DocumentIds = []),
    getLogPrdc(Sn1, Logged),
    getDocsPrdc(Sn1, ListDocs),
    revokemultiplyAccesesifOwner(DocumentIds,Logged,ListDocs,NewListDocs),
    setDocsPrdc(Sn1,NewListDocs,Sn),
    closelog(Sn,Sn2),!.

paradigmaDocsRevokeAllAccesses(Sn1, [], Sn2):-
    existlog(Sn1),
    getLogPrdc(Sn1, Logged),
    getDocsPrdc(Sn1, ListDocs),
    revokeAccessesAllDocsifOwner(Logged,ListDocs,NewListDocs),
    setDocsPrdc(Sn1,NewListDocs,Sn),
    closelog(Sn,Sn2).

paradigmaDocsSearch(Sn1, SearchText, Documents):-
    existlog(Sn1),
    getLogPrdc(Sn1, Logged),
    getDocsPrdc(Sn1, ListDocs),
    searchContentOnDocs(ListDocs,Logged, SearchText,Documents).

paradigmaDocsDelete(Sn1, DocumentId, Date, NumberOfCharacters, Sn2):-
    existlog(Sn1),
    getLogPrdc(Sn1, Logged),
    getDocsPrdc(Sn1, Docs),
    getSomeDoc(Docs,DocumentId,TheDoc),
    canWhatinDocs(TheDoc, Logged, "W"),
    deleteOnDocs(TheDoc, Date, NumberOfCharacters, NewDoc),
    setSomeDoc(Docs, DocumentId, NewDoc, NewDocs),
    setDocsPrdc(Sn1,NewDocs, Sn),
    closelog(Sn, Sn2).

paradigmaDocsSearchAndReplace(Sn1, DocumentId,  SearchText, ReplaceText, Sn2):-
    existlog(Sn1),
    getLogPrdc(Sn1, Logged),
    getDocsPrdc(Sn1, Docs),
    getSomeDoc(Docs,DocumentId,TheDoc),
    canWhatinDocs(TheDoc, Logged, "W"),
    searchAndReplaceOnDocs(TheDoc, SearchText, ReplaceText, NewDoc),
    setSomeDoc(Docs, DocumentId, NewDoc, NewDocs),
    setDocsPrdc(Sn1,NewDocs, Sn),
    closelog(Sn, Sn2).

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

test2(Usuario,StrOut):-
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
    paradigmaDocsRestoreVersion(PD13,0,0,PD14),
    getDocsPrdc(PD14,Docs),
    showEveryDoc(Docs,Usuario,StrOut).

test6(StrOut):-
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
    paradigmaDocsRestoreVersion(PD13,0,0,PD14),
    paradigmaDocsLogin(PD14, "vflores", "hola123", PD15),
    paradigmaDocsRevokeAllAccesses(PD15,[0],PD16),
    paradigmaDocsLogin(PD16, "vflores", "hola123", PD17),
    paradigmaDocsDelete(PD17, 0, [1,3,2020], 10, PD18),
    paradigmaDocsLogin(PD18, "vflores", "hola123", PD19),
    paradigmaDocsSearchAndReplace(PD19, 0, "hola","cepillin",PD20),
    paradigmaDocsToString(PD20, StrOut).

   

test3():-canWhatinDocs(["titulo",[1,2,2020],0,"Owner","contenido",[["vflores",["R","W"]]]],"vflores","R").


test4():-
    Users = [["alopez", "asdfg", [3, 12, 2021]],["crios", "qwert", [1, 12, 2021]],["vflores", "hola123", [1, 12, 2021]]],
    captchaUsers(["vflores","alopez"],Users).
test5(S):-
    addMultiplyAccesses(["Rodriguez","pedro","sebastian"],["W"],[["Rodriguez",["C","R","W"]]],S).
test7(NewDocs):-
    revokeAccessesAllDocsifOwner("peo",
        [["archivo 1", [1, 12, 2021], 0, "vflores", 
        [["hola mundo, este es elcontenido de un archivo", [1, 12, 2021], 0], 
        ["hola mundo, este es elcontenido de un archivo este es un nuevo texto", [20, 12, 2015], 1],
        ["hola mundo, este es elcontenido de un archivo", [1, 12, 2021], 2]]
        , [["alopez", ["W"]], ["crios", ["W", "R"]]]],["archivo 2", [1, 12, 2021], 1, "vflores", 
        [["hola mundo, este es elcontenido de un archivo", [1, 12, 2021], 0], 
        ["hola mundo, este es elcontenido de un archivo este es un nuevo texto", [20, 12, 2015], 1],
        ["hola mundo, este es elcontenido de un archivo", [1, 12, 2021], 2]]
        , [["alopez", ["W"]], ["crios", ["W", "R"]]]], [[[[]]]]]
    ,NewDocs).

