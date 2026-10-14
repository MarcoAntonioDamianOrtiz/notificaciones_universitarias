import 'package:flutter/material.dart';

import '../adapter/aviso_web_adapter.dart';
import '../adapter/fuente_notificacion.dart';
import '../adapter/sistema_avisos_web.dart';
import '../modelos/notificacion.dart';
import '../singleton/gestor_notificaciones.dart';
import '../widgets/tarjeta_notificacion.dart';
import 'historial_page.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  void _registrar(BuildContext context, Notificacion notificacion) {
    final gestor = GestorNotificaciones();
    final agregado = gestor.agregar(notificacion);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          agregado
              ? 'Notificación guardada: ${notificacion.tipo}'
              : 'Esta notificación ya está registrada.',
        ),
      ),
    );
  }

  void _registrarTarea(BuildContext context) {
    _registrar(
      context,
      const Notificacion(
        id: 'tarea-001',
        titulo: 'Nueva tarea de Matemáticas',
        mensaje: 'Resolver los ejercicios 1 al 10 para el viernes.',
        prioridad: 'media',
        tipo: 'Tarea',
      ),
    );
  }

  void _registrarExamen(BuildContext context) {
    _registrar(
      context,
      const Notificacion(
        id: 'examen-001',
        titulo: 'Examen de Programación',
        mensaje: 'El examen se realizará el próximo lunes.',
        prioridad: 'alta',
        tipo: 'Examen',
      ),
    );
  }

  void _importarAviso(BuildContext context) {
    // Ejemplo JSON del ejercicio: la web usa nombres de campos distintos.
    final avisoWeb = {
      'id': 'aviso-001',
      'asunto': 'Suspensión de clases',
      'contenido': 'Mañana no habrá clases',
      'nivel': 'urgente',
    };

    final sistemaWeb = SistemaAvisosWeb(avisoWeb);
    final FuenteNotificacion adaptador = AvisoWebAdapter(sistemaWeb);
    final avisoMovil = adaptador.obtenerNotificacion();

    _registrar(context, avisoMovil);
  }

  @override
  Widget build(BuildContext context) {
    final gestor = GestorNotificaciones();
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UniAvisos'),
        actions: [
          IconButton(
            key: const Key('btnHistorial'),
            tooltip: 'Ver historial',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const HistorialPage(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: gestor,
        builder: (context, _) {
          final recientes = gestor.notificaciones.take(3).toList();

          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: tema.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 38,
                      color: tema.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Notificaciones universitarias',
                      style: tema.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Simula tareas, exámenes y avisos utilizando Singleton y Adapter.',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Registradas: ${gestor.notificaciones.length}',
                      style: tema.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text('Simular acontecimientos', style: tema.textTheme.titleLarge),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  key: const Key('btnTarea'),
                  onPressed: () => _registrarTarea(context),
                  icon: const Icon(Icons.assignment_outlined),
                  label: const Text('Registrar una tarea'),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  key: const Key('btnExamen'),
                  onPressed: () => _registrarExamen(context),
                  icon: const Icon(Icons.edit_document),
                  label: const Text('Registrar un examen'),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  key: const Key('btnImportarAviso'),
                  onPressed: () => _importarAviso(context),
                  icon: const Icon(Icons.sync_alt),
                  label: const Text('Importar aviso web (Adapter)'),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Prueba a presionar dos veces el mismo botón: el Singleton evitará duplicados.',
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recientes', style: tema.textTheme.titleLarge),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const HistorialPage(),
                      ),
                    ),
                    child: const Text('Ver todas'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (recientes.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Sin notificaciones por ahora.'),
                  ),
                )
              else
                for (final notificacion in recientes)
                  TarjetaNotificacion(notificacion: notificacion),
            ],
          );
        },
      ),
    );
  }
}
