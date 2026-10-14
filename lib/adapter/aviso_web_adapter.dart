import '../modelos/notificacion.dart';
import 'fuente_notificacion.dart';
import 'sistema_avisos_web.dart';

/// Adapter: traduce los campos del sistema web al modelo móvil.
class AvisoWebAdapter implements FuenteNotificacion {
  final SistemaAvisosWeb sistemaWeb;

  AvisoWebAdapter(this.sistemaWeb);

  @override
  Notificacion obtenerNotificacion() {
    final datos = sistemaWeb.obtenerAvisoWeb();
    final titulo = (datos['asunto'] ??
            datos['tituloAviso'] ??
            'Aviso sin título')
        .toString();
    final nivel = (datos['nivel'] ?? 'normal').toString().toLowerCase();

    return Notificacion(
      id: (datos['id'] ?? 'web-$titulo').toString(),
      titulo: titulo,
      mensaje: (datos['contenido'] ?? '').toString(),
      prioridad: _convertirPrioridad(nivel),
      tipo: 'Aviso',
    );
  }

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
