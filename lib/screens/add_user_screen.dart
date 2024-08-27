import 'package:flutter/material.dart';
import 'package:my_sqflite/data/class/user_class_data.dart';
import 'package:my_sqflite/data/sqflite/db_sqflite_data.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Users? users = ModalRoute.of(context)?.settings.arguments as Users?;
    if (users != null) {
      nombreController.text = users.nombre ?? '';
      apellidoController.text = users.apellido ?? '';
      correoController.text = users.correo ?? '';
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(users != null ? 'Editar Usuario' : 'Agregar Usuario'),
        ),
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: nombreController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El nombre es obligatorio";
                        }
                        final regex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)?$');
                        if (!regex.hasMatch(value)) {
                          return "Solo deben tener letras";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: "Nombre"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: apellidoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El apellido es obligatorio";
                        }

                        final regex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)?$');
                        if (!regex.hasMatch(value)) {
                          return "Solo deben tener letras";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: "Apellido"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: correoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El correo es obligatorio";
                        }
                        final regex = RegExp(
                            r'^[a-z0-9._%+-]+@(gmail\.com|yahoo\.com|outlook\.com|iplus\.do)$');
                        if (!regex.hasMatch(value)) {
                          return "Ingrese un correo válido";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: "Correo"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validacion de que los campos esten completos
                        if (_formKey.currentState!.validate()) {
                          // Si Los datos son validos se guardara
                          if (users != null && users.id! > 0) {
                            users.nombre = nombreController.text;
                            users.apellido = apellidoController.text;
                            users.correo = correoController.text;
                            DB.update(users);
                          } else {
                            DB.insert(Users(
                              nombre: nombreController.text,
                              apellido: apellidoController.text,
                              correo: correoController.text,
                            ));
                          }
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
