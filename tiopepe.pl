
existeUsuario(Usuario, [FU|NLU]):-
    getterUsername(Usuario,Username),
	getterUsername(FU,Username),!.
existeUsuario(Usuario,[FU|NLU]):-
    existeUsuario(Usuario,NLU).

agregarUsuarioALaTienda(Tienda,IdUsuario, Username,NuevaTienda):-
    nuevoUsuario(IdUsuario,Username,NewUser),
    tienda(UsuarioActivo,ListUsers,ListaProductos,Tienda),
    not(existeUsuario(NewUser,ListUsers)),
    tienda(UsuarioActivo,[NewUser|ListUser],ListaProductos,NuevaTienda).

login([UsuarioActivo,ListUsers,ListaProductos,Tienda],Logged, [Logged, UsuarioActivo,ListUsers,ListaProductos,Tienda]):-
    existeUsuario(Usuario,ListUsers).