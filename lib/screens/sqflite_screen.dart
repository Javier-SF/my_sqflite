import 'package:flutter/material.dart';
import 'package:my_sqflite/data/class/user_class_data.dart';
import 'package:my_sqflite/data/sqflite/db_sqflite_data.dart';

class MySqfLite extends StatefulWidget {
  const MySqfLite({super.key});

  @override
  State<MySqfLite> createState() => _MySqfLiteState();
}

class _MySqfLiteState extends State<MySqfLite> {
  List<Users> usersList = [];
  @override
  void initState() {
    super.initState();
    cargaUsers();
  }

  cargaUsers() async {
    List<Users> auxUsers = await DB.users();
    setState(() {
      usersList = auxUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SQF Lite'),
        ),
        body: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onLongPress: () => _showOptionsDialog(context, usersList[i]),
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(
                    'Su nombre es: ${usersList[i].nombre} ${usersList[i].apellido}',
                  ),
                  subtitle: Text('El correo es: ${usersList[i].correo}'),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/editar",
              arguments: Users(id: 0, nombre: "", apellido: "", correo: ""),
            ).then((value) {
              if (value != null) {
                cargaUsers();
              }
            });
          },
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, Users user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccione una opción'),
          content: const Text('¿Estas seguro en realizar esta accion? '),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(context);
                _deleteUser(user);
              },
            ),
            TextButton(
              child: const Text('Editar', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/editar');
                _editUser(user);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(Users user) {
    DB.delete(user);
    setState(() {
      usersList.remove(user);
    });
  }

  void _editUser(Users user) {
    Navigator.pushNamed(
      context,
      "/editar",
      arguments: user,
    ).then((value) {
      if (value != null) {
        cargaUsers();
      }
    });
  }
}

// class MySqfLite extends StatefulWidget {
//   const MySqfLite({super.key});

//   @override
//   State<MySqfLite> createState() => _MySqfLiteState();
// }

// class _MySqfLiteState extends State<MySqfLite> {
//   List<Users> usersList = [];

//   @override
//   void initState() {
//     super.initState();
//     cargaUsers();
//   }

//   cargaUsers() async {
//     List<Users> auxUsers = await DB.users();
//     setState(() {
//       usersList = auxUsers;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('SQF Lite'),
//         ),
//         body: ListView.builder(
//           itemCount: usersList.length,
//           itemBuilder: (context, i) {
//             return Dismissible(
//               key: Key(usersList[i].id.toString()),
//               direction: DismissDirection.startToEnd,
//               confirmDismiss: (direction) async {
//                 // Retornar `false` para que no se descarte automáticamente
//                 return false;
//               },
//               background: _buildSwipeActionLeft(usersList[i]),
//               child: Card(
//                 elevation: 5,
//                 margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 child: ListTile(
//                   title: Text(
//                     'Su nombre es: ${usersList[i].nombre} ${usersList[i].apellido}',
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             Navigator.pushNamed(
//               context,
//               "/editar",
//               arguments: Users(id: 0, nombre: "", apellido: "", correo: ""),
//             ).then((value) {
//               if (value != null) {
//                 cargaUsers(); // Recargar la lista después de agregar
//               }
//             });
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildSwipeActionLeft(Users user) {
//     return Container(
//       color: Colors.blue,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           IconSlideAction(
//             color: Colors.red,
//             icon: Icons.delete,
//             onTap: () {
//               _deleteUser(user);
//             },
//           ),
//           IconSlideAction(
//             color: Colors.green,
//             icon: Icons.edit,
//             onTap: () {
//               _editUser(user);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _deleteUser(Users user) {
//     // Acción de eliminar usuario
//     DB.delete(user);
//     setState(() {
//       usersList.remove(user);
//     });
//   }

//   void _editUser(Users user) {
//     // Acción de editar usuario
//     Navigator.pushNamed(
//       context,
//       "/editar",
//       arguments: user,
//     ).then((value) {
//       if (value != null) {
//         cargaUsers(); // Recargar la lista después de editar
//       }
//     });
//   }
// }

// class IconSlideAction extends StatelessWidget {
//   final Color color;
//   final IconData icon;
//   final VoidCallback onTap;

//   const IconSlideAction({
//     super.key,
//     required this.color,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: double.infinity,
//         width: 80,
//         color: color,
//         child: Icon(
//           icon,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
//     );
//   }
// }
