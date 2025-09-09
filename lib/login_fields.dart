import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({super.key});

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  // estado mutable
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _obscure = true; // ocultar/mostrar contraseña
  bool _loading = false; // estado de carga
  String? _error; // mensaje de error

  @override
  void dispose() {
    // liberar recursos
    _emailController.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // enviar formulario
    FocusScope.of(context).unfocus();
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) {
      setState(
        () => _error = 'Revisa los campos resaltados.',
      ); // actualizar estado
      return; // no válido
    }
    setState(() {
      _error = null; // limpiar error
      _loading = true; // iniciar carga
    });

    try {
      await Future<void>.delayed(
        const Duration(milliseconds: 400),
      ); // simular espera

      if (!mounted) return; // verificar si el widget sigue en el árbol
      Navigator.of(
        context,
      ).pushReplacementNamed('/home', arguments: _emailController.text.trim());
    } catch (_) {
      setState(
        () => _error = 'Ocurrió un error inesperado.',
      ); // actualizar estado
    } finally {
      if (mounted) setState(() => _loading = false); // finalizar carga
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        autovalidateMode:
            AutovalidateMode.onUserInteraction, // validar al interactuar
        child: Column(
          // columna de campos
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // estirar horizontalmente
          mainAxisSize: MainAxisSize.min, // ajustar al contenido
          children: [
            Center(
              child: Image.network(
                //Cargar imagen desde URL
                "https://i.ibb.co/N0prLgv/login.webp",
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              // boton ingresar
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        // indicador de carga
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Ingresar"), // texto del boton
            ),

            if (_error != null) ...[
              // mostrar error si existe
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red), // texto rojo
                textAlign: TextAlign.center,
              ),
            ],

            const SizedBox(height: 8), // espacio
            const Text(
              "Iniciar Sesión",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ), // titulo
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // RF2: validación de correo
            TextFormField(
              enabled: !_loading,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              enableSuggestions: true,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(
                labelText: "Correo Electrónico",
                hintText: "ejemplo@correo.cl",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final value = v?.trim() ?? "";
                if (value.isEmpty) return 'El correo es obligatorio';
                final emailOk = RegExp(
                  r'^[\w\.\-+%]+@([A-Za-z0-9\-]+\.)+[A-Za-z]{2,}$',
                ).hasMatch(value);
                return emailOk
                    ? null
                    : 'El correo no es válido (debe incluir @).';
              },
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: 16),

            // validación de contraseña
            TextFormField(
              enabled: !_loading, // deshabilitar si está cargando
              controller: _passCtrl,
              keyboardType: TextInputType.visiblePassword, // tipo de teclado
              textCapitalization: TextCapitalization.none, // sin mayúsculas
              autocorrect: false,
              enableSuggestions: false,
              autofillHints: const [AutofillHints.password], // autocompletar
              obscureText: _obscure,
              decoration: InputDecoration(
                // decoración del campo
                labelText: "Contraseña",
                hintText: "********", // no mostrar contraseña
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(), // borde del campo
                suffixIcon: IconButton(
                  // botón para mostrar/ocultar
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure; // cambiar estado
                    });
                  },
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) // campo obligatorio
                  return 'La contraseña es obligatoria';
                if (value.length < 6)
                  return 'La contraseña debe tener al menos 6 caracteres';
                return null;
              },
              onFieldSubmitted: (_) => _submit(), // enviar al presionar enter
            ),
          ],
        ),
      ),
    );
  }
}
