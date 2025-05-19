import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class MultipleSensorDisplay extends StatefulWidget {
  const MultipleSensorDisplay({Key? key}) : super(key: key);

  @override
  _MultipleSensorDisplayState createState() => _MultipleSensorDisplayState();
}

class _MultipleSensorDisplayState extends State<MultipleSensorDisplay> {
  double? _humedad;
  double? _temperatura;
  double? _coRaw;
  double? _no2Raw;
  double? _pm10;
  double? _pm25;

  final _humedadRef = FirebaseDatabase.instance.ref('dht11/humedad');
  final _temperaturaRef = FirebaseDatabase.instance.ref('dht11/temperatura');
  final _coRawRef = FirebaseDatabase.instance.ref('mics4514/co_raw');
  final _no2RawRef = FirebaseDatabase.instance.ref('mics4514/no2_raw');
  final _pm10Ref = FirebaseDatabase.instance.ref('sds011/pm10');
  final _pm25Ref = FirebaseDatabase.instance.ref('sds011/pm25');

  late StreamSubscription<DatabaseEvent> _humedadSubscription;
  late StreamSubscription<DatabaseEvent> _temperaturaSubscription;
  late StreamSubscription<DatabaseEvent> _coRawSubscription;
  late StreamSubscription<DatabaseEvent> _no2RawSubscription;
  late StreamSubscription<DatabaseEvent> _pm10Subscription;
  late StreamSubscription<DatabaseEvent> _pm25Subscription;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _humedadSubscription.cancel();
    _temperaturaSubscription.cancel();
    _coRawSubscription.cancel();
    _no2RawSubscription.cancel();
    _pm10Subscription.cancel();
    _pm25Subscription.cancel();
    super.dispose();
  }

  void _startListening() {
    _humedadSubscription = _humedadRef.onValue.listen(
      (DatabaseEvent event) {
        final dynamic value = event.snapshot.value;
        if (event.snapshot.exists && value is num) {
          setState(() {
            _humedad = value.toDouble();
          });
        } else {
          setState(() {
            _humedad = null;
          });
          // Considera usar un logger en lugar de print para apps en producción
          print('No hay datos o valores invalidos de humedad');
        }
      },
      onError: (Object error) {
        print('Error al leer humedad: $error');
        setState(() {
          _humedad = null;
        });
      },
    );

    _temperaturaSubscription = _temperaturaRef.onValue.listen(
      (DatabaseEvent event) {
        final dynamic value = event.snapshot.value;
        if (event.snapshot.exists && value is num) {
          setState(() {
            _temperatura = value.toDouble();
          });
        } else {
          setState(() {
            _temperatura = null;
          });
          print('No hay datos o valores invalidos de temperatura');
        }
      },
      onError: (Object error) {
        print('Error al leer temperatura: $error');
        setState(() {
          _temperatura = null;
        });
      },
    );

    _coRawSubscription = _coRawRef.onValue.listen(
      (DatabaseEvent event) {
        final dynamic value = event.snapshot.value;
        if (event.snapshot.exists && value is num) {
          setState(() {
            _coRaw = value.toDouble();
          });
        } else {
          setState(() {
            _coRaw = null;
          });
          print('No hay datos o valores invalidos de co_raw');
        }
      },
      onError: (Object error) {
        print('Error al leer co_raw: $error');
        setState(() {
          _coRaw = null;
        });
      },
    );

    _no2RawSubscription = _no2RawRef.onValue.listen(
      (DatabaseEvent event) {
        final dynamic value = event.snapshot.value;
        if (event.snapshot.exists && value is num) {
          setState(() {
            _no2Raw = value.toDouble();
          });
        } else {
          setState(() {
            _no2Raw = null;
          });
          print('No hay datos o valores invalidos de no2_raw');
        }
      },
      onError: (Object error) {
        print('Error al leer no2_raw: $error');
        setState(() {
          _no2Raw = null;
        });
      },
    );

    _pm10Subscription = _pm10Ref.onValue.listen(
      (DatabaseEvent event) {
        final dynamic value = event.snapshot.value;
        if (event.snapshot.exists && value is num) {
          setState(() {
            _pm10 = value.toDouble();
          });
        } else {
          setState(() {
            _pm10 = null;
          });
          print('No hay datos o valores invalidos de pm10');
        }
      },
      onError: (Object error) {
        print('Error al leer pm10: $error');
        setState(() {
          _pm10 = null;
        });
      },
    );

    _pm25Subscription = _pm25Ref.onValue.listen(
      (DatabaseEvent event) {
        final dynamic value = event.snapshot.value;
        if (event.snapshot.exists && value is num) {
          setState(() {
            _pm25 = value.toDouble();
          });
        } else {
          setState(() {
            _pm25 = null;
          });
          print('No hay datos o valores invalidos de pm25');
        }
      },
      onError: (Object error) {
        print('Error al leer pm25: $error');
        setState(() {
          _pm25 = null;
        });
      },
    );
  }

  // Helper mejorado para mostrar un valor o un placeholder dentro de una Card
  Widget _buildSensorCard(
    String label,
    double? value,
    String unit,
    IconData icon,
  ) {
    return Card(
      // Usamos Card para darle un contenedor visualmente agradable
      elevation: 4.0, // Añade una pequeña sombra
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 0.0,
      ), // Margen entre tarjetas
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio dentro de la tarjeta
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              // Usamos un Row para el icono y la etiqueta
              children: [
                Icon(
                  icon,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ), // Icono
                SizedBox(width: 12.0), // Espacio entre icono y texto
                Text(
                  label,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (value != null)
              Text(
                '${value.toStringAsFixed(1)} $unit', // Formatear a un decimal
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey[700],
                ), // Un color un poco más suave
              )
            else
              Text(
                'Cargando...',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Permite hacer scroll si la lista de datos es larga
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Título con un icono
            Row(
              children: [
                Icon(
                  Icons.sensors,
                  size: 30.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Datos de Sensores:',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24), // Espacio después del título
            // Usamos las nuevas tarjetas para cada sensor
            _buildSensorCard(
              'Humedad',
              _humedad,
              '%',
              Icons.water_drop_outlined,
            ), // Icono de gota
            _buildSensorCard(
              'Temperatura',
              _temperatura,
              '°C',
              Icons.thermostat_outlined,
            ), // Icono de termómetro
            _buildSensorCard(
              'Monóxido Carbono',
              _coRaw,
              'ppm',
              Icons.cloud_outlined,
            ), // Icono genérico de aire
            _buildSensorCard(
              'Dióxido Nitrógeno',
              _no2Raw,
              'ppm',
              Icons.cloud_outlined,
            ), // Icono genérico de aire
            _buildSensorCard(
              'PM10',
              _pm10,
              'µg/m³',
              Icons.grain,
            ), // Icono de grano/partícula
            _buildSensorCard(
              'PM2.5',
              _pm25,
              'µg/m³',
              Icons.grain,
            ), // Icono de grano/partícula
            // Ya no necesitamos los Divider() entre las tarjetas
          ],
        ),
      ),
    );
  }
}
