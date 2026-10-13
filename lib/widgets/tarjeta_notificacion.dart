import 'package:flutter/material.dart';

import '../modelos/notificacion.dart';

/// Elemento visual reutilizado en Inicio e Historial.
class TarjetaNotificacion extends StatelessWidget {
  final Notificacion notificacion;

  const TarjetaNotificacion({super.key, required this.notificacion});

  // Cada tipo (tarea, examen o aviso) recibe un ícono representativo.
  IconData get _icono {
    switch (notificacion.tipo) {
      case 'Tarea':
        return Icons.assignment_outlined;
      case 'Examen':
        return Icons.edit_document;
      default:
        return Icons.campaign_outlined;
    }
  }

  // El color permite identificar visualmente la prioridad del aviso.
  Color _color(BuildContext context) {
    if (notificacion.prioridad == 'alta') return Colors.deepOrange;
    if (notificacion.prioridad == 'baja') return Colors.teal;
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(context);

    // Se reutiliza esta tarjeta tanto en Inicio como en Historial.
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(_icono, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificacion.titulo,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(notificacion.mensaje),
                  const SizedBox(height: 9),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Chip(
                        label: Text(notificacion.tipo),
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        avatar: Icon(Icons.flag_outlined, size: 16, color: color),
                        label: Text('Prioridad ${notificacion.prioridad}'),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
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
