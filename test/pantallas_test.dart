import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notificaciones_universitarias/app.dart';
import 'package:notificaciones_universitarias/singleton/gestor_notificaciones.dart';

void main() {
  setUp(() => GestorNotificaciones().limpiar());

  testWidgets('El aviso adaptado aparece también en el historial', (tester) async {
    await tester.pumpWidget(const NotificacionesApp());

    expect(GestorNotificaciones().notificaciones, isEmpty);

    final boton = find.byKey(const Key('btnImportarAviso'));
    await tester.ensureVisible(boton);
    await tester.tap(boton);
    await tester.pumpAndSettle();

    expect(GestorNotificaciones().notificaciones.length, 1);
    expect(GestorNotificaciones().notificaciones.first.titulo,
        'Suspensión de clases');

    await tester.tap(find.byKey(const Key('btnHistorial')));
    await tester.pumpAndSettle();

    expect(find.text('Historial de notificaciones'), findsOneWidget);
    expect(find.text('Suspensión de clases'), findsOneWidget);
  });
}
