class Users {
  // Esta son la variables de la class.

  int? id;
  String? nombre, apellido;
  String? correo;

// contructor y sus parametros
  Users({
    this.id,
    this.nombre,
    this.apellido,
    this.correo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
    };
  }
}
