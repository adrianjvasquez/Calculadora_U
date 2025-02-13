import 'package:calculadora_de_interes/domain/controller/calculations/calculate_annuities.dart';
import 'package:calculadora_de_interes/domain/controller/calculations/calculate_gradients.dart';
import 'package:calculadora_de_interes/domain/controller/calculations/calculate_simple_interest.dart';
import 'package:calculadora_de_interes/domain/controller/data/data.dart';
import 'package:calculadora_de_interes/ui/app.dart';
import 'package:calculadora_de_interes/domain/controller/auth_controller.dart'; // Nuevo controlador para autenticación
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(Data());
  Get.put(CalculateSimpleInterest());
  Get.put(CalculateAnnuities());
  Get.put(CalculateGradients());
  Get.put(AuthController()); // Registrar el controlador de autenticación

  runApp(const MyApp());
}
