import 'package:flutter/material.dart';
import 'login_fields.dart';

class LoginScreen extends StatelessWidget {
  // pantalla login
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // cerrar teclado al tocar fuera
      onTap: () =>
          FocusScope.of(context).unfocus(), // cerrar teclado al tocar fuera
      child: const Scaffold(
        // pantalla
        body: SafeArea(
          child: SingleChildScrollView(
            // para pantallas pequeñas
            padding: EdgeInsets.all(24), // padding
            child: LoginFields(),
          ),
        ),
      ),
    );
  }
}
