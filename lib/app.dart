import 'package:flutter/material.dart';

import 'pantallas/inicio_page.dart';

class NotificacionesApp extends StatelessWidget {
  const NotificacionesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniAvisos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const InicioPage(),
    );
  }
}
