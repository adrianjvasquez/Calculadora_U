import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _fontSize = 16.0; // Tamaño de texto predeterminado
  bool _highContrast = false; // Opción de alto contraste

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: const Color(0xFF013542),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Ajustar Tamaño de Texto',
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              min: 10,
              max: 30,
              value: _fontSize,
              onChanged: (newValue) {
                setState(() {
                  _fontSize = newValue;
                });
              },
            ),
            Text(
              'Tamaño actual: ${_fontSize.toStringAsFixed(1)}',
              style: TextStyle(fontSize: _fontSize),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Activar Alto Contraste'),
              value: _highContrast,
              onChanged: (value) {
                setState(() {
                  _highContrast = value;
                  if (_highContrast) {
                    Get.changeTheme(ThemeData.light().copyWith(
                      scaffoldBackgroundColor: Colors.white,
                      primaryColor: Colors.black,
                      textTheme: const TextTheme(
                        bodyLarge: TextStyle(color: Colors.black),
                        bodyMedium: TextStyle(color: Colors.black),
                        bodySmall: TextStyle(color: Colors.black),
                      ),
                    ));
                  } else {
                    Get.changeTheme(ThemeData.light());
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
