/// Modelo utilizado por nuestra aplicación móvil.
class Notificacion {
  // El id identifica cada acontecimiento; se usa para evitar duplicados.
  final String id;
  final String titulo;
  final String mensaje;
  final String prioridad;
  final String tipo;

  const Notificacion({
    required this.id,
    required this.titulo,
    required this.mensaje,
    required this.prioridad,
    required this.tipo,
  });
}
