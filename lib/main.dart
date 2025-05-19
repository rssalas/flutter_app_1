import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/Pages.dart';
import 'package:flutter_application_1/pages/firebase_options.dart';

import 'package:flutter_application_1/pages/multiple_sensor_display.dart';
import 'package:flutter_application_1/pages/Pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitor de Calidad del Aire',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'E.S.E HOSPITAL SANTA CRUZ DE URUMITA.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ), // Estilo del texto
          ),
          centerTitle: true, // Centra el título en la AppBar
          backgroundColor: Colors.blue, // Color de fondo de la AppBar
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/imagenes/UNIVERSIDAD.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              // se usa SingleChildScrollView para evitar overflow
              child: Center(
                // widget para mostrar los datos
                child: MultipleSensorDisplay(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              alignment: MainAxisAlignment.center,
              overflowSpacing: 5.0,
              children: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  icon: const Icon(Icons.info, color: Colors.white),
                  label: const Text(
                    'Información',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoPage()),
                    );
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  icon: const Icon(Icons.show_chart, color: Colors.white),
                  label: const Text(
                    'Graficos',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                ),
              ],
            ),
          ), // Color de fondo del BottomAppBar
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
