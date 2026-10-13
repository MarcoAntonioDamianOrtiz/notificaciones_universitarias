import 'package:flutter_test/flutter_test.dart';
import 'package:notificaciones_universitarias/adapter/aviso_web_adapter.dart';
import 'package:notificaciones_universitarias/adapter/sistema_avisos_web.dart';
import 'package:notificaciones_universitarias/modelos/notificacion.dart';
import 'package:notificaciones_universitarias/singleton/gestor_notificaciones.dart';

void main() {
  // El Singleton conserva estado; lo limpiamos para aislar cada prueba.
  setUp(() => GestorNotificaciones().limpiar());

  test('Singleton devuelve siempre la misma instancia', () {
    final pantallaInicio = GestorNotificaciones();
    final pantallaHistorial = GestorNotificaciones();

    expect(identical(pantallaInicio, pantallaHistorial), isTrue);
  });

  test('Singleton comparte los datos entre las pantallas', () {
    final inicio = GestorNotificaciones();
    final historial = GestorNotificaciones();

    inicio.agregar(const Notificacion(
      id: 'tarea-001',
      titulo: 'Tarea',
      mensaje: 'Entregar mañana',
      prioridad: 'media',
      tipo: 'Tarea',
    ));

    expect(historial.notificaciones.length, 1);
    expect(historial.notificaciones.first.titulo, 'Tarea');
  });

  test('El gestor evita registrar dos veces el mismo acontecimiento', () {
    const notificacion = Notificacion(
      id: 'tarea-001',
      titulo: 'Tarea repetida',
      mensaje: 'Texto',
      prioridad: 'media',
      tipo: 'Tarea',
    );

    final gestor = GestorNotificaciones();
    expect(gestor.agregar(notificacion), isTrue);
    expect(gestor.agregar(notificacion), isFalse);
    expect(gestor.notificaciones.length, 1);
  });

  // Verifica que Adapter cambie nombres de campos y nivele la prioridad.
  test('Adapter traduce el JSON del ejercicio al modelo móvil', () {
    final sistema = SistemaAvisosWeb({
      'asunto': 'Suspensión de clases',
      'contenido': 'Mañana no habrá clases',
      'nivel': 'urgente',
    });

    final aviso = AvisoWebAdapter(sistema).obtenerNotificacion();

    expect(aviso.titulo, 'Suspensión de clases');
    expect(aviso.mensaje, 'Mañana no habrá clases');
    expect(aviso.prioridad, 'alta');
    expect(aviso.tipo, 'Aviso');
  });

  test('El Adapter también acepta el nuevo campo tituloAviso', () {
    final sistema = SistemaAvisosWeb({
      'tituloAviso': 'Entrega de becas',
      'contenido': 'Consulta la convocatoria',
      'nivel': 'normal',
    });

    final aviso = AvisoWebAdapter(sistema).obtenerNotificacion();

    expect(aviso.titulo, 'Entrega de becas');
    expect(aviso.prioridad, 'media');
  });
}
