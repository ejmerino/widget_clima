import 'package:flutter/material.dart';
import '../controlador/clima_controlador.dart';
import '../modelo/clima_modelo.dart';
import 'clima_widget.dart';

class ClimaVista extends StatefulWidget {
  @override
  ClimaVistaState createState() => ClimaVistaState();
}

class ClimaVistaState extends State<ClimaVista> {
  final TextEditingController ciudadC = TextEditingController();
  final ClimaControlador climaC = ClimaControlador();

  ClimaModelo? climaModelo;

  // Función para obtener el clima y actualizar el estado
  void obtenerYActualizarClima() async {
    final ciudad = ciudadC.text.trim();
    if (ciudad.isNotEmpty) {
      final clima = await climaC.obtenerClima(ciudad);
      setState(() {
        climaModelo = clima;
      });
    } else {
      setState(() {
        climaModelo = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light); // Color scheme azul

    return Scaffold(
      backgroundColor: colorScheme.background, // Usa el color de fondo predeterminado
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 2, // Reduce la elevación para una apariencia más plana
        centerTitle: true,
        title: Text(
          "Clima",
          style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onPrimary), //Text color on the container
        ),
      ),
      body: SingleChildScrollView( // Agregado para evitar overflow
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Aumenta el padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Alinea los widgets al inicio
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40), // Espacio superior

              // Caja de texto para ingresar la ciudad
              TextFormField(
                controller: ciudadC,
                style: TextStyle(fontSize: 18, color: colorScheme.onBackground), // Usar onSurface para el texto
                decoration: InputDecoration(
                  labelText: "Ingresa la ciudad",
                  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant), // Usa un color sutil para la etiqueta
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                    borderSide: BorderSide.none, // Sin borde
                  ),
                  prefixIcon: Icon(Icons.search, color: colorScheme.primary),
                  filled: true,
                  fillColor: colorScheme.surfaceVariant, // Un tono sutil para el fondo
                  hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                  hintText: 'Ej. Londres',
                ),
              ),
              const SizedBox(height: 24),

              // Botón para ver el clima
              ElevatedButton(
                onPressed: obtenerYActualizarClima,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1, // Sutil elevación
                ),
                child: Text(
                  "Ver clima",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: colorScheme.onPrimary), // OnPrimary para el texto
                ),
              ),

              const SizedBox(height: 32),

              // Mostrar el clima si se obtuvo correctamente
              AnimatedSwitcher(  // Transición suave entre los widgets
                duration: const Duration(milliseconds: 300),
                child: climaModelo != null
                    ? Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClimaWidget(
                    ciudad: climaModelo!.ciudad,
                    temperatura: climaModelo!.temperatura,
                    descripcion: climaModelo!.descripcion,
                  ),
                )
                    : Center(
                  child: Text(
                    "Ingresa una ciudad para ver el clima.",
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}