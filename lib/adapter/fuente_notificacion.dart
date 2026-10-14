import '../modelos/notificacion.dart';

/// Interfaz que la aplicación entiende, como MedioPago o Impresora.
abstract class FuenteNotificacion {
  Notificacion obtenerNotificacion();
}
