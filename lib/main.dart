// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sqflite/screens/home_screens.dart';
import 'package:my_sqflite/screens/sqflite_screen.dart';
import 'package:my_sqflite/screens/add_user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: PaginatedListView(),
      home: const ProfileScreen(),
      // home: const HomeScreens(),
      routes: {
        '/home': (context) => const HomeScreens(),
        '/list': (context) => const MySqfLite(),
        '/editar': (context) => const AddUsers()
      },
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  ///Aqui cargamos la imagen guardada en sharedPreferences
  Future<void> loadImage() async {
    SharedPreferences ses = await SharedPreferences.getInstance();
    String? imagePath = ses.getString('image_path');
    if (imagePath != null) {
      ///aqui guardamo la ruta de imagen
      setState(() {
        selectedImage = File(imagePath);
      });
    }
  }

  // Guardar la ruta de la imagen en SharedPreferences
  Future<void> saveImagePath(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image_path', imagePath);
  }

  //Aqui es para cambiar la imagen
  Future<void> changeImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        selectedImage = file;
      });

      saveImagePath(file.path);
    }
  }

  /// Esta funcion es para eliminar la imagen que cargue dentro de ses
  Future<void> dImage() async {
    SharedPreferences ses = await SharedPreferences.getInstance();
    ses.remove('image_path');

    setState(() {
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: changeImages,
              child: SizedBox(
                // color: Colors.amber,
                // height: 200,
                // width: 200,
                child: Stack(
                  children: [
                    if (selectedImage != null)
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(selectedImage!),
                      )
                    else
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.person,
                          size: 210,
                          color: Colors.grey.shade100,
                        ),
                      ),
                    Positioned(
                      top: 160,
                      left: 160,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: pickAndSaveImage,
            //   child: const Text("Pick and Save Image"),
            // ),
            ElevatedButton(
              onPressed: dImage,
              child: const Text("Delete Image"),
            ),

            if (selectedImage != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(selectedImage!),
              )
            else
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  Icons.person,
                  size: 75,
                  color: Colors.grey.shade100,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/**
 * 
 * De las tres funciones que proporcionaste, todas son necesarias si tu aplicación necesita la funcionalidad completa de:

Cargar una imagen previamente guardada al iniciar (función loadImage).
Guardar la ruta de una imagen seleccionada para que persista entre sesiones (función saveImagePath).
Cambiar la imagen seleccionada desde la galería y actualizar tanto el estado como el almacenamiento (función changeImages).
Sin embargo, si decides simplificar el flujo o quitar cierta funcionalidad, podrías considerar eliminar alguna de las siguientes:

Eliminación posible
saveImagePath:
Si tu aplicación no necesita recordar la imagen seleccionada entre sesiones, esta función se vuelve innecesaria. En tal caso, podrías simplemente manejar la imagen en memoria temporalmente.

loadImage:
Si no necesitas que la imagen seleccionada previamente se recargue al reiniciar la aplicación, esta función también sería innecesaria. Esto sería el caso si no estás utilizando persistencia de datos para las imágenes.

En resumen:

Mantén todas si necesitas persistencia entre sesiones.
Elimina loadImage y saveImagePath si no necesitas recordar la imagen entre sesiones.
¿Podrías detallar más sobre los requerimientos de tu aplicación? Eso ayudaría a identificar cuál es realmente innecesaria.
 */
