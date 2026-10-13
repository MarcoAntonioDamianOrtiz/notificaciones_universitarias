/// Simula el sistema web antiguo de la universidad.
/// No usamos internet: el sistema entrega un Map que representa un JSON.
class SistemaAvisosWeb {
  final Map<String, dynamic> avisoWeb;

  SistemaAvisosWeb(this.avisoWeb);

  // Devuelve el Map original; no conoce el modelo utilizado por Flutter.
  Map<String, dynamic> obtenerAvisoWeb() {
    return avisoWeb;
  }
}
