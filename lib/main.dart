import 'package:calculadora_de_interes/domain/controller/calculations/calculate_annuities.dart';
import 'package:calculadora_de_interes/domain/controller/calculations/calculate_simple_interest.dart';
import 'package:calculadora_de_interes/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(CalculateSimpleInterest());
  Get.put(CalculateAnnuities());

  runApp(const MyApp());
}
