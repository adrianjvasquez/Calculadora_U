import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;

  Future<void> register(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    Get.snackbar('Registro exitoso', 'Te has registrado correctamente');
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    if (email == storedEmail && password == storedPassword) {
      isAuthenticated.value = true;
      Get.toNamed('/home');
    } else {
      Get.snackbar('Error', 'Correo o contraseña incorrectos');
    }
  }

  Future<void> loginWithBiometrics() async {
    // Aquí puedes agregar lógica adicional si es necesario
    isAuthenticated.value = true;
    Get.toNamed('/home');
  }

  Future<void> logout() async {
    isAuthenticated.value = false;
    Get.toNamed('/login');
  }
}
