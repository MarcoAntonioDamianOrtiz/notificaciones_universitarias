import '../modelos/notificacion.dart';
import 'fuente_notificacion.dart';
import 'sistema_avisos_web.dart';

/// Adapter: traduce los campos del sistema web al modelo móvil.
class AvisoWebAdapter implements FuenteNotificacion {
  final SistemaAvisosWeb sistemaWeb;

  AvisoWebAdapter(this.sistemaWeb);

  @override
  Notificacion obtenerNotificacion() {
    // Lee el JSON simulado tal como lo entrega el sistema antiguo.
    final datos = sistemaWeb.obtenerAvisoWeb();
    // Acepta los nombres asunto o tituloAviso, sin cambiar las pantallas.
    final titulo = (datos['asunto'] ??
            datos['tituloAviso'] ??
            'Aviso sin título')
        .toString();
    final nivel = (datos['nivel'] ?? 'normal').toString().toLowerCase();

    // Construye el objeto con los nombres y tipos que entiende nuestra app.
    return Notificacion(
      id: (datos['id'] ?? 'web-$titulo').toString(),
      titulo: titulo,
      mensaje: (datos['contenido'] ?? '').toString(),
      prioridad: _convertirPrioridad(nivel),
      tipo: 'Aviso',
    );
  }

  // Adapta los niveles externos (urgente, bajo...) a alta, media o baja.
  String _convertirPrioridad(String nivel) {
    if (nivel == 'urgente' || nivel == 'alto') {
      return 'alta';
    }
    if (nivel == 'bajo') {
      return 'baja';
    }
    return 'media';
  }
}
