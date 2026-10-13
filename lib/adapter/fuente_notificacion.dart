import '../modelos/notificacion.dart';

/// Interfaz que la aplicación entiende, como MedioPago o Impresora.
abstract class FuenteNotificacion {
  // Contrato: cualquier fuente compatible entrega el modelo de la app.
  Notificacion obtenerNotificacion();
}
