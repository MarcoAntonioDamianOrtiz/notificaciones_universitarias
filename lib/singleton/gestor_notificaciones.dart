import 'package:flutter/foundation.dart';

import '../modelos/notificacion.dart';

/// Singleton: todas las pantallas consultan la MISMA instancia.
class GestorNotificaciones extends ChangeNotifier {
  GestorNotificaciones._(); // Constructor privado.

  // Esta instancia única será compartida por todas las pantallas.
  static final GestorNotificaciones _instancia = GestorNotificaciones._();

  // Igual que el Singleton visto en la clase Configuracion de "patrones".
  factory GestorNotificaciones() => _instancia;

  final List<Notificacion> _notificaciones = [];

  // Se expone una lista de solo lectura para impedir cambios desde las vistas.
  List<Notificacion> get notificaciones =>
      List.unmodifiable(_notificaciones);

  /// Devuelve false si ese acontecimiento ya fue registrado.
  bool agregar(Notificacion notificacion) {
    // Si el id ya existe, no se vuelve a registrar el mismo acontecimiento.
    if (_notificaciones.any((item) => item.id == notificacion.id)) {
      return false;
    }

    _notificaciones.insert(0, notificacion);
    // Avisa a Inicio e Historial que deben actualizar lo que muestran.
    notifyListeners();
    return true;
  }

  void limpiar() {
    _notificaciones.clear();
    notifyListeners();
  }
}
