import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calculadora_de_interes/domain/controller/auth_controller.dart';
import 'package:local_auth/local_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find();
  final LocalAuthentication auth = LocalAuthentication();
  bool isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

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

  Future<void> _registerWithBiometrics() async {
    // Implementa la lógica de registro de huella dactilar
    Get.snackbar('Huella registrada', 'Tu huella ha sido registrada exitosamente');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nombre')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Correo Electrónico'), keyboardType: TextInputType.emailAddress),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Contraseña'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.register(nameController.text, emailController.text, passwordController.text);
              },
              child: Text('Registrarse'),
            ),
            SizedBox(height: 20),
            if (isBiometricAvailable)
              ElevatedButton.icon(
                onPressed: _registerWithBiometrics,
                icon: Icon(Icons.fingerprint),
                label: Text('Registrar Huella Dactilar'),
              ),
          ],
        ),
      ),
    );
  }
}
