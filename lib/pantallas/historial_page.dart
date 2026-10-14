import 'package:flutter/material.dart';

import '../singleton/gestor_notificaciones.dart';
import '../widgets/tarjeta_notificacion.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Es el mismo Singleton que usa InicioPage.
    final gestor = GestorNotificaciones();

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de notificaciones')),
      body: AnimatedBuilder(
        animation: gestor,
        builder: (context, _) {
          final notificaciones = gestor.notificaciones;

          if (notificaciones.isEmpty) {
            return const Center(
              child: Text('Todavía no tienes notificaciones.'),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '${notificaciones.length} notificaciones registradas',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              for (final notificacion in notificaciones)
                TarjetaNotificacion(notificacion: notificacion),
            ],
          );
        },
      ),
    );
  }
}
