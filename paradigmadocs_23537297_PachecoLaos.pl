%---------------------------------------------------------------------------------
%--------------------------Predicados Generales------------------------------------
%---------------------------------------------------------------------------------
/*
======Dominios======
BigWord     : String
LfWord      : String
FirstNumber : Entero
FinalNumber : Entero
Lista       : lista
NewLista    : lista
Count       : Entero
Total       : Entero
Number      : Entero
Componente  : varios
=====Predicados=====
existSubStr(BigWord,Lfword)
searchWord(BigWord, LfWord, FirstNumber, FinalNumber)
contarlista(Lista, FirstNumber, Total)
append(Lista, Componente, NewLista)
nth0(Number, Lista, Componente)
nth1(Number, Lista, Componente)
========Metas=======
--Primarias
searchWord
--secundarias
existSubStr
contarlista
append
nth0
nth1
=====Clausulas=====
Reglas
*/
%descripcion: busca dentro de uns string la existencia de otro string
existSubStr(BigWord,LfWord):-
    string_length(LfWord,Largo),
    searchword(BigWord,LfWord,1,Largo).

%descripcion: busca dentro de un string la existencia de otro string tras ingresar ciertos parametros
searchword(BigWord,LfWord,FirstNumber,FinalNumber):-
    substring(BigWord,FirstNumber,FinalNumber,LfWord),!.
searchword(BigWord,LfWord,FirstNumber,FinalNumber):-
    string_length(BigWord,Largo),
    substring(BigWord,2,Largo,NewBigWord),
    searchword(NewBigWord,LfWord,FirstNumber,FinalNumber).

%descripcion: cuenta la cantidad de elementos de una lista tras ingresar lista, 0, N; siendo N
%el largo de la lista
contarlista([],FirstNumber,FirstNumber).
contarlista([_|L],FirstNumber,Total):- Newcount is FirstNumber+1, contarlista(L,Newcount,Total).


/*
Fundamentos para poder ocupar estas predicados
%descripcion: agrega al final de una lista un componente
append([],Componente,[Componente]).
append([FirstComp|Next], Componente, [FirstComp|BeforeLista]):-
    append(Next,Componente,BeforeLista).

%descripcion: retorna un componente en particualr senialando su posicion contando desde 0
nth0(Number, [Componente|_], Componente):-
    Number = 0,!.
nth0(Number, [_|Next], Componente):-
    NewNumber is Number - 1,
    nth0(NewNumber, Next, Componente).

%descripcion: retorna un componente en particualr senialando su posicion contando desde 1
nth1(Number, [Componente|_], Componente):-
    Number = 1,!.
nth1(Number, [_|Next], Componente):-
    NewNumber is Number - 1,
    nth0(NewNumber, Next, Componente).
*/

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
getYear(Fecha,Anio)
dateToString(Fecha,StrFecha)
========Metas=======
--Primarias--
getDay
getMonth
getYear
--secundarias--
date
dateToString
=====Clausulas=====
Reglas
*/
%de la forma: Dia(int), mes(int), anio(int)
%descripcion: genera una fecha al ingresar 3 valores distintos, siendo la cuarta entrada la fecha
date(Dia,Mes,Anio,[Dia,Mes,Anio]):- Dia > 0, Dia < 32,Mes > 0 ,Mes < 13, Anio >= 1900, Anio < 2022.

%descripcion: al ingresar un fecha devuelve el dia correspondiente a tal fecha
getDay([Dia|_], SDay):- Dia= SDay.
%descripcion: al ingresar un fecha devuelve el mes correspondiente a tal fecha
getMonth([_,Mes|_], SMonth):- Mes = SMonth.
%descripcion: al ingresar un fecha devuelve el anio correspondiente a tal fecha
getYear([_,_,Anio|_], SYear):- Anio = SYear.

%descripcion: tras ingresar un fecha retorna un string de formato "dia-mes-agnio"
dateToString(Date,StrOut):-
    getDay(Date,Day),
    number_string(Day,StrDay),
    getMonth(Date,Month),
    number_string(Month,StrMonth),
    getYear(Date,Year),
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
%descripcion: retorna un user tras ingresar cada uno de sus componentes
user(Username, Pass, Date, [Username, Pass, Date]).

%descripcion: retorna el nombre de usuario del user
getUsernameUser([Username|_],Username).
%descripcion: retorna la contrasenia del user
getPassUser([_,Pass|_],Pass).
%descripcion: retorna la fecha de creacion de user
getDateUser([_,_,Date],Date).

%descripcion: verifica la igualdad entre dos nombre de usuarios
sameUsername([Username1|_],[Username1|_]).
%descripcion: verifica la igualdad entre dos contrasenias
samePassword([_,Pass1|_],[_,Pass1|_]).
%descripcion: transforma un user a string
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
%descripcion: genera un doc tras ingresar cada uno de sus componentes
docsCreate(Name, Date, Id, Owner, Contenido,[Name, Date,Id, Owner,[NewVersion],[]]):-
    version(Contenido,Date,0,NewVersion).
%descripcion: retorna el id del documento
getId([_,_,Id|_],Id).
%descripcion: retorna el titulo del documento
getTitle([Title|_],Title).
%descripcion: retorna la fecha de creacion del documento
getCreation([_,Creation|_],Creation).
%descripcion: retorna el nombre del propietario del documento
getOwnerDoc([_,_,_,Owner|_],Owner).
%descripcion: retorna las versiones del documento
getContentDoc([_,_,_,_,Content,_|_],Content).
%descripcion: retorna la lista de accesos al documento del documento
getAccessesDoc([_,_,_,_,_,Accesses], Accesses).

%descripcion: retorna un documento con la lista de versiones actualizada
setVersionsDoc([Name, Date,Id, Owner,_,Accesses|_],NewVersions,[Name, Date,Id, Owner,NewVersions,Accesses]).
%descripcion: retorna un documento con la lista de accesos actualizada
setAccessesDoc([Name, Date,Id, Owner,Versions,_|_],NewAccesses,[Name, Date,Id, Owner,Versions,NewAccesses]).
%descripcion: verifica si el propietario coincide con un nombre de usuario ingresado
isOwner([_,_,_,Owner|_],Owner).

%descripcion: retorna un documento con una versión senialda llevada a la versión actual
restoreVersionDocs(Doc,IdVersion,DocSalida):-
    getContentDoc(Doc,VersionesDoc),
    contarlista(VersionesDoc,0,NewID),
    nth0(IdVersion,VersionesDoc,LFVersion),
    setIdVersion(LFVersion,NewID,NewVersion),
    append(VersionesDoc,[NewVersion],NewListVersions),
    setVersionsDoc(Doc,NewListVersions,DocSalida).

%descripcion: agrega contenido a la ultima version del documento generando una nueva version
addContent(DocEntrada,Date,NewContent,DocSalida):-
    getContentDoc(DocEntrada,VersionesDoc),
    contarlista(VersionesDoc,0,LargoVersiones),
    nth1(LargoVersiones,VersionesDoc,LastVersion),
    getContenidoVrsn(LastVersion,ContenidoLastVersion),
    string_concat(ContenidoLastVersion,NewContent,NewContentofVrsn),
    version(NewContentofVrsn,Date,LargoVersiones,NewVersion),
    append(VersionesDoc,[NewVersion],NewVersions),
    setVersionsDoc(DocEntrada,NewVersions,DocSalida).

%descripcion: verifica que permiso en particular tiene un usuario senialado
canWhatinDocs([_,_,_,Owner|_],Owner,_):-!,true.
canWhatinDocs([_,_,_,_,_,ListAccesses|_],Name,Letter):-
    getAccessSomeUser(ListAccesses,Name,SomeAccess),
    getListAccessUser(SomeAccess,ListAccessUser),
    canWhat(ListAccessUser,Letter).

%descripcion: retorna el acceso que tiene un usuario senialado
getAccessSomeUser([FirstAccess|_],Name,FirstAccess):- getNameAccess(FirstAccess,Name),!.
getAccessSomeUser([_|NextAccesses],Name,AccessUser):- getAccessSomeUser(NextAccesses,Name,AccessUser).

%descripcion: retorna el acceso de un usuario en particular actualizada por el ingresado
addOneAccess([],Access,[Access]).
addOneAccess([LastAccess|NextAccesses],Access,[Access|NextAccesses]):-
    getNameAccess(LastAccess,Name1),
    getNameAccess(Access,Name1),!.
addOneAccess([LastAccess|NextAccess],Access,[LastAccess|Accesses]):-
    addOneAccess(NextAccess,Access,Accesses).

%descripcion: retorna una lista de accesos actualizada de todos los accesos ingresados
addMultiplyAccesses([],_,OldAccesses,OldAccesses):-!.
addMultiplyAccesses([LastUsername|NextUsernames],Permissions,OldAccesses,NewAccesses):-
    addMultiplyAccesses(NextUsernames,Permissions,OldAccesses,NextNew),
    access(LastUsername,Permissions,A),
    addOneAccess(NextNew,A,NewAccesses).

%descripcion: validará StrOut como la muestra del documento senialado,
% de acuerdo al tipo de permiso que tiene el usuario
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

%descripcion: retorna el contenido de la última versión del doc como string
showLastVersion(ListVersions,StrOut):-
    contarlista(ListVersions,0,Largo),
    nth1(Largo,ListVersions,TheLastVersion),
    versionToString(TheLastVersion,StrVersion),
    string_concat(StrVersion,"\n",StrOut).

%descripcion: retorna el contenido de todas las versiones de una lista de versiones como string
showEveryVersion([],"").
showEveryVersion([Head|Next],StrOut):-
    showEveryVersion(Next,StrAnother),
    versionToString(Head,StrVersion),
    string_concat(StrVersion,"\n",WithJump),
    string_concat(StrAnother,WithJump,StrOut).

%descripcion: retorna como string el contenido de un acceso en particular
showOneAccess([Head|_],User,StrOut):-
    getNameAccess(Head,User),
    !,
    accessToString(Head,StrOut).
showOneAccess([_|NextAccess],User,StrOut):-
    showOneAccess(NextAccess,User,StrOut).


%descripcion: retorna como string el contenido de todos los accesos del documento
showEveryAccess([],"").
showEveryAccess([Head|Next],StrOut):- 
    showEveryAccess(Next,Out),
    string_concat(Out,"\n",WithJump),
    accessToString(Head,StrAccess),
    string_concat(WithJump,StrAccess,StrOut).

%descripcion: retorna como string todo el contenido de un documento
showAllInformationDoc(Documento,StrOut):-
    getTitle(Documento,Title),%=============Title
    getCreation(Documento,DateCreation),
    dateToString(DateCreation,StrDate),%=============StrDate
    getId(Documento, Id),
    number_string(Id, StrId),
    string_concat("Id Doc: ",StrId, BId),
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

%descripcion: retorna como string todo el contenido de un documento
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

%descripcion: retorna el contenido que puede ver del documento un usuario invitado
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
    
%descripcion: retorna un documento con su lista de accesos vacia
revokeAccessesDoc(Documento, NewDocument):-
    setAccessesDoc(Documento,[],NewDocument).

%descripcion: busca un contenido en particular dentro de un documento
searchContentOnDoc(Doc,ContentLF):-
    getContentDoc(Doc,Versions),
    searchOnVersions(Versions,ContentLF).

%descripcion: busca un contenido en particular dentro de la lista de versiones
searchOnVersions([FirsVersion|_],ContentLF):-
    existContentinVersion(FirsVersion,ContentLF),!.
searchOnVersions([_,NextVersions],ContentLF):-
    searchOnVersions(NextVersions,ContentLF).

%descripcion: elimina una cantidad de caracteres en un documento
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

%descripcion: reemplaza un contenido en particular dentro de un documento
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
%descripcion: retorna una version tras ingresar cada uno de sus componentes
version(Contenido,Date,Id,[Contenido,Date,Id]).

%descripcion: retorna un contenido de una version
getContenidoVrsn([Contenido|_],Contenido).
%descripcion: retorna la fecha de una version
getDateVrsn([_,Date|_],Date).
%descripcion: retorna el id de una version
getIdVrsn([_,_,Id|_],Id).
%descripcion: retorna una nueva version con su id reemplazado por el ingresado
setIdVersion([Contenido,Date,_],NewId,[Contenido,Date,NewId]).
%descripcion: retorna en string una version
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

%descripcion: retorna si existe un string dentro de alguna version
existContentinVersion(Version,ContentLF):-
    getContenidoVrsn(Version,Contenido),
    existSubStr(Contenido,ContentLF).



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
%descripcion: retorna un acceso tras ingresar cada uno de sus componentes
access(Name,ListKindAccess,[Name,ListKindAccess]).
%descripcion: retorna el nombre de el acceso
getNameAccess([Name|_],Name).
%descripcion: retorna los permisos que tiene le acceso
getListAccessUser([_,ListKindAccess|_],ListKindAccess).

%descripcion: retorna un booleando tras ingresar la lista de permisos y el permiso buscado
canWhat([],_):- !,fail.
canWhat([FirstAccess|_],FirstAccess):- !, true.
canWhat([_|NextKindAccess],Letter):-canWhat(NextKindAccess,Letter).

%descripcion: retorna como string la lista de permisos que tiene un usuario en particular
listAccessToString([],"").
listAccessToString([Head|Next],StrOut):-
    listAccessToString(Next,Out),
    string_concat(Out,"-",XD),
    string_concat(XD,Head,StrOut).

%descripcion: retorna como string un acceso
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

%descripcion: retorna un paradigmaDocs pero con la lista de usuario actualizada
setUsersPrdc([Name,Date,Log,_,Docs|_],NewUsers,[Name,Date,Log,NewUsers,Docs]).
%descripcion: retorna un paradigmaDocs pero con el usuario logueado actualizado
setLogPrdc([Name,Date,_,Users,Docs|_],NewLog,[Name,Date,NewLog,Users,Docs]).
%descripcion: retorna un paradigmaDocs pero con la lista de documentos actualizada
setDocsPrdc([Name,Date,Log,Users,_|_],NewDocs,[Name,Date,Log,Users,NewDocs]).
%descripcion: retorna el nombre de un paradigmaDocs
getNamePrdc([Name|_],Name).
%descripcion: retorna la fecha de creacion de un paradigmaDocs
getDatePrdc([_,Date|_],Date).
%descripcion: retorna la lista de usuario de un paradigmaDocs
getUsersPrdc([_,_,_,Users,_|_],Users).
%descripcion: retorna el usuario logueado de un paradigmaDocs
getLogPrdc([_,_,Log,_,_|_],Log).
%descripcion: retorna la lista de documentos de un paradigmaDocs
getDocsPrdc([_,_,_,_,Docs|_],Docs).

%descripcion: verifica la existencia de algun usuario logueado
existlog(Sn):-not(getLogPrdc(Sn,"")).
%descripcion: cierra la sesion de paradigmaDocs
closelog([Name,Date,_,Users,Docs|_],[Name,Date,"",Users,Docs]).

%descripcion: verifica la existencia de algun usuario con un nombre de usuario en particular
existUsername([],_):- !, fail.
existUsername([FU|_],User):- sameUsername(FU,User),!,true.
existUsername([_|LU],User):- existUsername(LU,User).
%descripcion: verifica la existencia de un usuario
existUser([],_):- !, fail.
existUser([FU|_],User):- sameUsername(FU,User), samePassword(FU,User),!,true.
existUser([_|LU],User):- existUser(LU,User).
%descripcion: retorna un documento tras senialar el id de tal
getSomeDoc([FD|_],Id,FD):-getId(FD,Id),!,true.
getSomeDoc([_|LD],Id,FD):-getSomeDoc(LD,Id,FD).

%descripcion:retorna un documento tras senialar su id
setSomeDoc([Doc|LD],Id,NewDoc,[NewDoc|LD]):-getId(Doc,Id),!.
setSomeDoc([Doc|LD],Id,NewDoc,[Doc|NextLD]):-setSomeDoc(LD,Id,NewDoc,NextLD).

%descripcion: verifica la existencia de una lista de usuario dentro de una lista de usuarios
captchaUsers([],_).
captchaUsers([FNewUser|NewUsers],UsersFPrdc):-
    user(FNewUser,"",[],U),
    existUsername(UsersFPrdc,U),
    captchaUsers(NewUsers,UsersFPrdc).

%descripcion: muestra cada documento de una lista de documentos
showEveryDoc([],_, "").
showEveryDoc([FirstDoc|NextDocs],User,StrOut):-
    showEveryDoc(NextDocs,User,OutNextDocs),
    showDoc(FirstDoc, User, StrFirstDoc),
    string_concat(StrFirstDoc,OutNextDocs,StrOut).

%descripcion: muestra cada usuario dentro de una lista de usuarios
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

%descripcion: revoca los permisos de un documento en particular tras senialar su id
revokeAccessesifOwner([FirstDoc|NextDocs], User, Id,[NewDoc|NextDocs]):-
    getId(FirstDoc,Id),!,
    isOwner(FirstDoc, User),
    revokeAccessesDoc(FirstDoc,NewDoc),!.
revokeAccessesifOwner([FirstDoc|NextDocs],User,Id,[FirstDoc|NewDocs]):-
    revokeAccessesifOwner(NextDocs,User,Id,NewDocs).

%descripcion: revoca los permisos de multiples accesos senialando multiples ids
revokemultiplyAccesesifOwner([],_, OldDocs,OldDocs).
revokemultiplyAccesesifOwner([FirstId|NextIds], User, OldDocs,NewDocs):-
    revokeAccessesifOwner(OldDocs, User,FirstId,BeforesNewDocs),
    revokemultiplyAccesesifOwner(NextIds, User, BeforesNewDocs,NewDocs).

%descripcion: revoca los permisos de todos los documento de los que se es propietario
revokeAccessesAllDocsifOwner(_,[],[]).
revokeAccessesAllDocsifOwner(User,[FirstDoc|NextDocs],[NewDoc|BeforeNextDocs]):-
    isOwner(FirstDoc,User),
    revokeAccessesDoc(FirstDoc,NewDoc),
    revokeAccessesAllDocsifOwner(User, NextDocs, BeforeNextDocs).
revokeAccessesAllDocsifOwner(User,[FirstDoc|NextDocs],[FirstDoc|BeforeNextDocs]):-
    revokeAccessesAllDocsifOwner(User, NextDocs, BeforeNextDocs).

%descripcion: busca un contenido en particular dentro de todos los documento, siempre y cuando
% se puedan y retorna todos los documento que lo tienen
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
    (isOwner(Doc0,Logged);canWhatinDocs(Doc0,Logged,"S")),
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
/*
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

   

test3():
    -canWhatinDocs(["titulo",[1,2,2020],0,"Owner","contenido",[["vflores",["R","W"]]]],"vflores","R").


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
*/


% === Testeo paradigmadocsDocs ===
test1(PD1):-% generación de plataforma con nombre "google docs"
    date(20, 12, 2015, D1),
    paradigmaDocs("google Docs", D1, PD1).


% === Testeos paradigmaDocsRegister ===
test2(PD4):- % se registran 3 usuarios distintos
    date(20, 12, 2015, D1),
    date(1, 12, 2021, D2),
    date(3,12, 2021, D3),
    test1(PD1),
    paradigmaDocsRegister(PD1, D2, "ElPepe", "123456", PD2),
    paradigmaDocsRegister(PD2, D3, "Sebastian", "asdfgh", PD3),
    paradigmaDocsRegister(PD3, D1, "CharlesAranguis", "123456", PD4).
test3(PD5):- % intento de registro de usuario que ya existe dentro de la plataforma
    date(20, 12, 2015, D1),
    test2(PD4),
    paradigmaDocsRegister(PD4, D1, "ElPepe", "rth",PD5).

% === Testeos paradigmaDocsLogin ===
test4(PD6):- % Se logue "ElPepe"
    test2(PD5),
    paradigmaDocsLogin(PD5, "ElPepe", "123456", PD6).
test5(PD6):- % Se logue "Sebastian"
    test2(PD5),
    paradigmaDocsLogin(PD5, "Sebastian", "asdfgh", PD6).
test6(PD6):-% Intento de logueo de con contrasenia incorrecta
    test2(PD5),
    paradigmaDocsLogin(PD5, "Sebastian", "123456", PD6).
% === Testeos paradigmaDocsCreate ===
test7(PD14):- %se generan 3 documentos distintos dentro de la plataforma
    date(20, 12, 2015, D1),
    date(1, 12, 2021, D2),
    date(3,12, 2021, D3),
    test5(PD6),
    paradigmaDocsLogin(PD6, "ElPepe", "123456", PD7),
    paradigmaDocsCreate(PD7, D1, "Lista de deseos", "Aqui iran mis deseos: ", PD8),
    paradigmaDocsLogin(PD8, "Sebastian", "asdfgh", PD9),
    paradigmaDocsCreate(PD9, D2, "Resumen Ingles", "escribire mi resumen de infles aqui", PD10),
    paradigmaDocsLogin(PD10, "CharlesAranguis","123456", PD11),
    paradigmaDocsCreate(PD11, D3, "Filosofio", "", PD12),
    paradigmaDocsLogin(PD12, "ElPepe", "123456", PD13),
    paradigmaDocsCreate(PD13, D1, "Resumen", "No han pasado clase aun.", PD14).

test8(PD15):- %Se trata de generar un documento sin haberse logueado antes
    date(20, 12, 2015, D1),
    test7(PD14),
    paradigmaDocsCreate(PD14, D1, "pruebas", "contenido",PD15).

% === Testeos paradigmaDocsShare ===

test9(PD20):-
    test7(PD14),
    paradigmaDocsLogin(PD14, "ElPepe", "123456", PD15),
    %Se comparten permisos del documento 0 con Charles y Seba  de tipo 
    %"W", "R" y "C"
    paradigmaDocsShare(PD15, 0, ["W","R","C"],["CharlesAranguis", "Sebastian"],PD16),
    paradigmaDocsLogin(PD16, "ElPepe", "123456", PD17),
    %Se comparten permisos del documento 3 con Charles y Seba  de tipo 
    %"R" y "C"
    paradigmaDocsShare(PD17, 3, ["R","C"],["CharlesAranguis", "Sebastian"],PD18),
    paradigmaDocsLogin(PD18, "CharlesAranguis", "123456", PD19),
    %Se comparten permisos del documento 2 con ElPepe y Seba  de tipo 
    %"R" y "C"
    paradigmaDocsShare(PD19, 2, ["W","R","C"], ["ElPepe", "Sebastian"],PD20).
test10(PD22):- % se trata de compartir un documento del que no se es propietario
    test9(PD20),
    paradigmaDocsLogin(PD20, "CharlesAranguis", "123456", PD21),
    paradigmaDocsShare(PD21, 0, ["W"], ["ElPepe"],PD22).

% === Testeos paradigmaDocsAdd ===

test11(PD26):- % se agrega contenido a diferentes documentos
    date(1, 12, 2021, D2),
    test9(PD20),
    paradigmaDocsLogin(PD20, "ElPepe", "123456", PD21),
    paradigmaDocsAdd(PD21, 0, D2, "Primer deseo: conseguir pasar la carrera", PD22),
    paradigmaDocsLogin(PD22, "CharlesAranguis", "123456", PD23),
    paradigmaDocsAdd(PD23, 0, D2, " Segundo deseo: conseguir una casa", PD24),
    paradigmaDocsLogin(PD24,"Sebastian", "asdfgh", PD25),
    paradigmaDocsAdd(PD25, 2, D2,"Una de las principales ramas de la filosofia...", PD26).

test12(PD28):- % se trata de agregar contenido a un documento en el que no se tiene permiso.
    date(1, 12, 2021, D2),
    test11(PD26),
    paradigmaDocsLogin(PD26, "CharlesAranguis", "123456", PD27),
    paradigmaDocsAdd(PD27, 3,D2,"puedo escribir en este documento",PD28).

% === Testeos paradigmaDocsRestoreVersion ===

test13(PD28):- % se restaura la versión 1 del documento 0
    test11(PD26),
    paradigmaDocsLogin(PD26, "ElPepe", "123456", PD27),
    paradigmaDocsRestoreVersion(PD27, 0, 1, PD28).

test14(PD30):- %se trata de restaurar una versión sin ser autor
    test13(PD28),
    paradigmaDocsLogin(PD28, "CharlesAranguis", "123456", PD29),
    paradigmaDocsRestoreVersion(PD29, 0,2, PD30).

% === Testeos paradigmaDocsToString ===

test15(StrOut):- % con usuario logueado
    test13(PD28),
    paradigmaDocsLogin(PD28, "CharlesAranguis", "123456", PD29),
    paradigmaDocsToString(PD29, StrOut).

test16(StrOut):- % sin usuario logueado
    test13(PD28),
    paradigmaDocsToString(PD28, StrOut).

% === Testeos paradigmaDocsRevokeAllAccesses ===

test17(PD30):- % accesos eliminados para documentos en particular
    test13(PD28),
    paradigmaDocsLogin(PD28, "CharlesAranguis", "123456", PD29),
    paradigmaDocsRevokeAllAccesses(PD29, [2], PD30).

test18(PD32):- % accesos eliminados para todo documento al que se es owner
    test17(PD30),
    paradigmaDocsLogin(PD30, "ElPepe", "123456", PD31),
    paradigmaDocsRevokeAllAccesses(PD31, [], PD32).

test19(PD34):- % se trata de revocar accesos a un documento del que no se es propietario
    test18(PD32),
    paradigmaDocsLogin(PD32, "CharlesAranguis", "123456", PD33),
    paradigmaDocsRevokeAllAccesses(PD33, [0], PD34).

% === Testeos paradigmaDocsSearch ===

test20(Docs):- % se buscan documentos con un string en particular
    test13(PD28),
    paradigmaDocsLogin(PD28, "CharlesAranguis", "123456", PD29),
    paradigmaDocsSearch(PD29, "Aqui", Docs).

test21(Docs):- % se buscan documentos con un strin inexistente
    test13(PD28),
    paradigmaDocsLogin(PD28, "CharlesAranguis", "123456", PD29),
    paradigmaDocsSearch(PD29, "cepillin", Docs).

% === Testeos paradigmaDocsDelete ===

test22(PD30):- % se borran 10 caracteres del documento 0
    date(20, 12, 2015, D1),
    test13(PD28),
    paradigmaDocsLogin(PD28, "CharlesAranguis", "123456", PD29),
    paradigmaDocsDelete(PD29, 0, D1, 10, PD30).

test23(PD32):- % se tratan de borrar caracteres en documento sin permisos
    date(20, 12, 2015, D1),
    test22(PD30),
    paradigmaDocsLogin(PD30, "CharlesAranguis", "123456", PD31),
    paradigmaDocsDelete(PD31, 3, D1, 10, PD32).

% === Testeos paradigmaDocsSearchAndReplace ===
test24(PD34):-
    test22(PD32),
    paradigmaDocsLogin(PD32, "CharlesAranguis", "123456", PD33),
    paradigmaDocsSearchAndReplace(PD33, 0,"aqui", "Lejos", PD34).