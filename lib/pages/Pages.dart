import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> gases = const [
    {
      'name': 'Dióxido de Nitrógeno (NO₂)',
      'efectos': 'Irritación de ojos, nariz y garganta.',
      'sintomas': 'Tos, dificultad para respirar, agravamiento de asma.',
      'consecuencias': 'Problemas respiratorios crónicos, daño pulmonar.',
    },
    {
      'name': 'Monóxido de Carbono (CO)',
      'efectos': 'Reduce la capacidad de la sangre para transportar oxígeno.',
      'sintomas': 'Dolor de cabeza, mareo, debilidad, náuseas.',
      'consecuencias': 'Daño cerebral, muerte en exposiciones altas.',
    },
    {
      'name': 'Material Particulado 2.5 (PM2.5)',
      'efectos': 'Penetra profundamente en los pulmones.',
      'sintomas': 'Irritación ocular, tos, dificultad respiratoria.',
      'consecuencias': 'Enfermedades cardíacas y pulmonares, cáncer.',
    },
    {
      'name': 'Material Particulado 10 (PM10)',
      'efectos': 'Afecta vías respiratorias superiores.',
      'sintomas': 'Estornudos, tos, irritación de garganta.',
      'consecuencias': 'Agravamiento de enfermedades respiratorias.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Información de Exposición')),
      body: ListView.builder(
        itemCount: gases.length,
        itemBuilder: (context, index) {
          final gas = gases[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gas['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Efectos: ${gas['efectos']}'),
                  Text('Síntomas: ${gas['sintomas']}'),
                  Text('Consecuencias: ${gas['consecuencias']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Ejemplo de cómo navegar a InfoPage desde un botón de información:
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Principal')),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InfoPage()),
            );
          },
        ),
      ),
    );
  }
}
