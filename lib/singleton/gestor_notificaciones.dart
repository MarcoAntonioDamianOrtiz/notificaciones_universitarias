import 'package:flutter/foundation.dart';

import '../modelos/notificacion.dart';

/// Singleton: todas las pantallas consultan la MISMA instancia.
class GestorNotificaciones extends ChangeNotifier {
  GestorNotificaciones._(); // Constructor privado.

  static final GestorNotificaciones _instancia = GestorNotificaciones._();

  // Igual que el Singleton visto en la clase Configuracion de "patrones".
  factory GestorNotificaciones() => _instancia;

  final List<Notificacion> _notificaciones = [];

  List<Notificacion> get notificaciones =>
      List.unmodifiable(_notificaciones);

  /// Devuelve false si ese acontecimiento ya fue registrado.
  bool agregar(Notificacion notificacion) {
    if (_notificaciones.any((item) => item.id == notificacion.id)) {
      return false;
    }

    _notificaciones.insert(0, notificacion);
    notifyListeners();
    return true;
  }

  void limpiar() {
    _notificaciones.clear();
    notifyListeners();
  }
}
