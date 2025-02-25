import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class ClimaWidget extends StatelessWidget {
  final String ciudad;
  final double temperatura;
  final String descripcion;

  ClimaWidget({
    required this.ciudad,
    required this.temperatura,
    required this.descripcion,
  });

  IconData _getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'cielo claro':
      case 'despejado':
        return WeatherIcons.day_sunny;
      case 'algo de nubes':
      case 'pocas nubes':
        return WeatherIcons.cloud;
      case 'nubes dispersas':
      case 'nublado':
        return WeatherIcons.cloudy;
      case 'lluvia ligera':
      case 'lluvia moderada':
      case 'lluvia intensa':
      case 'llovizna':
        return WeatherIcons.rain;
      case 'tormenta':
      case 'tormenta eléctrica':
      case 'tormenta con lluvia':
        return WeatherIcons.thunderstorm;
      case 'nieve':
      case 'nevando':
        return WeatherIcons.snow;
      case 'neblina':
      case 'niebla':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.na;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        padding: EdgeInsets.all(30),
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade800, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 25,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ciudad,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black38,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            BoxedIcon(
              _getWeatherIcon(descripcion),
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              '${temperatura.toStringAsFixed(1)} °C',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black38,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                descripcion.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
