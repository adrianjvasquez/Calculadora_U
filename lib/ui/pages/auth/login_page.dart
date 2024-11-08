import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calculadora_de_interes/domain/controller/auth_controller.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(); // Cambiado a correo
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find(); // Accede al controlador de autenticación

  final LocalAuthentication auth = LocalAuthentication(); // Instancia de autenticación local
  bool isBiometricAvailable = false; // Variable para verificar si biometría está disponible

  @override
  void initState() {
    super.initState();
    _checkBiometrics(); // Verifica si el dispositivo tiene biometría disponible
  }

  // Método para verificar si el dispositivo tiene huella o reconocimiento facial
  Future<void> _checkBiometrics() async {
    try {
      bool canAuthenticate = await auth.canCheckBiometrics || await auth.isDeviceSupported();
      setState(() {
        isBiometricAvailable = canAuthenticate;
      });
    } catch (e) {
      print("Error verificando biometría: $e");
    }
  }

  // Método para autenticar con huella
  Future<void> _authenticateWithBiometrics() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Por favor, autentícate usando tu huella digital',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        // Aquí puedes llamar a la función de login sin necesidad de correo/contraseña
        authController.loginWithBiometrics();
      }
    } catch (e) {
      print("Error durante la autenticación: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController, // Cambiado a correo
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.login(
                  emailController.text, passwordController.text,
                );
              },
              child: Text('Iniciar Sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF013542),
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            if (isBiometricAvailable)
              ElevatedButton.icon(
                onPressed: _authenticateWithBiometrics, // Llama al método de autenticación con huella
                icon: Icon(Icons.fingerprint),
                label: Text('Iniciar Sesión con Huella'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF013542),
                  foregroundColor: Colors.white,
                ),
              ),
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: Text('¿No tienes cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
