import 'package:flutter_test/flutter_test.dart';
import 'package:notificaciones_universitarias/app.dart';
import 'package:notificaciones_universitarias/singleton/gestor_notificaciones.dart';

void main() {
  testWidgets('La aplicación muestra la pantalla de inicio', (tester) async {
    GestorNotificaciones().limpiar();

    await tester.pumpWidget(const NotificacionesApp());

    expect(find.text('UniAvisos'), findsOneWidget);
    expect(find.text('Simular acontecimientos'), findsOneWidget);
  });
}
