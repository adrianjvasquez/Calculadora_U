import 'package:flutter/material.dart';
import 'dart:math';

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final _formKey = GlobalKey<FormState>();
  String _interestType = 'simple'; // Valor por defecto
  double _loanAmount = 0;
  double _interestRate = 0; // Porcentaje de interés
  int _totalDays = 0; // Total de días

  // Controladores para el monto y el tiempo
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();

  // Función para calcular el total a pagar
  double _calculateTotalPayment() {
    double totalAmount = 0;
    double principal = _loanAmount;
    double rate = _interestRate / 100; // Convertir porcentaje a decimal
    int totalDays = _totalDays;

    if (_interestType == 'simple') {
      // Fórmula para interés simple
      double totalInterest = principal * rate * (totalDays / 365); // Calcular interés
      totalAmount = principal + totalInterest; // Total a pagar
    } else {
      // Fórmula para interés compuesto
      totalAmount = principal * pow((1 + rate), totalDays / 365);
    }

    return totalAmount; // Retorna el total a pagar
  }

  // Función para calcular los días totales
  int _calculateTotalDays() {
    int years = int.tryParse(_yearsController.text) ?? 0;
    int months = int.tryParse(_monthsController.text) ?? 0;
    int days = int.tryParse(_daysController.text) ?? 0;

    return (years * 365) + (months * 30) + days; // Sumar días
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF013542),
        title: const Text(
          'Calculadora de Préstamos',
          style: TextStyle(color: Colors.white), // Título en blanco
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(), // Abre el Drawer
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF013542),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Página Principal'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Interés Simple'),
              onTap: () {
                Navigator.pop(context);
                // Navegar a otra página si es necesario
              },
            ),
            ListTile(
              title: const Text('Interés Compuesto'),
              onTap: () {
                Navigator.pop(context);
                // Navegar a otra página si es necesario
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _interestType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _interestType = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        child: Text("Interés Simple"),
                        value: "simple",
                      ),
                      DropdownMenuItem(
                        child: Text("Interés Compuesto"),
                        value: "compuesto",
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Tipo de Interés',
                      prefixIcon: Icon(Icons.account_balance),
                    ),
                  ),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Monto del Préstamo',
                      prefixIcon: Icon(Icons.attach_money), // Ícono para el monto
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un monto';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _interestRateController,
                    decoration: InputDecoration(
                      labelText: 'Tasa de Interés (%)',
                      prefixIcon: Icon(Icons.percent), // Ícono para el porcentaje de interés
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa la tasa de interés';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _yearsController,
                          decoration: InputDecoration(
                            labelText: 'Años',
                            prefixIcon: Icon(Icons.calendar_today), // Ícono para los años
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _monthsController,
                          decoration: InputDecoration(
                            labelText: 'Meses',
                            prefixIcon: Icon(Icons.calendar_view_month), // Ícono para los meses
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _daysController,
                    decoration: InputDecoration(
                      labelText: 'Días',
                      prefixIcon: Icon(Icons.today), // Ícono para los días
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loanAmount = double.parse(_amountController.text);
                          _interestRate = double.parse(_interestRateController.text);
                          _totalDays = _calculateTotalDays(); // Calcula los días totales
                        });

                        double totalPayment = _calculateTotalPayment();

                        // Mostrar resultado en un diálogo
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('Total a pagar por el préstamo: \$${totalPayment.toStringAsFixed(2)}'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF013542), // Color verde oscuro
                      foregroundColor: Colors.white, // Texto en blanco
                    ),
                    child: Text('Calcular Préstamo'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
