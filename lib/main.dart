import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() => runApp(const MyApp()); // punto de entrada

class MyApp extends StatelessWidget {
  // widget raíz
  const MyApp({super.key}); // constructor
  @override
  Widget build(BuildContext context) {
    // RF9: estilo corporativo
    const inacapRed = Color(0xFFD32F2F);
    return MaterialApp(
      // aplicación
      //  rutas
      debugShowCheckedModeBanner: false,
      title: 'Horama',
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(), // pantalla login
        '/home': (_) => const HomeScreen(), // pantalla bienvenida
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: inacapRed,
          brightness: Brightness.light, // modo claro
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          // AppBar rojo
          backgroundColor: inacapRed,
          foregroundColor: Colors.white, // color del texto y los iconos
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // botones rojos
          style: ElevatedButton.styleFrom(
            backgroundColor: inacapRed,
            foregroundColor: Colors.white,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          // botones rojos
          style: FilledButton.styleFrom(
            backgroundColor: inacapRed,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

// Pantalla de bienvenida con correo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // consultar argumentos
    final email = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido')), // Titulo
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ajustar al contenido
            children: [
              const SizedBox(height: 12),
              Text(
                email != null ? '¡Hola, $email!' : '¡Hola!', // mostrar correo
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                // boton cerrar sesion
                onPressed: () {
                  Navigator.of(
                    // volver a login
                    context,
                  ).pushNamedAndRemoveUntil('/login', (r) => false);
                },
                icon: const Icon(Icons.logout), // logo cerrar sesion
                label: const Text('Cerrar sesión'), // texto del boton
              ),
            ],
          ),
        ),
      ),
    );
  }
}
