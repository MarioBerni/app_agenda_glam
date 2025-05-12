import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/di/service_locator.dart';
import 'package:app_agenda_glam/core/theme/app_theme.dart'; 

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Glam',
      theme: AppTheme.darkTheme, 
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const Scaffold(
        body: Center(
          child: Text('Bienvenido a Agenda Glam'),
        ),
      ),
    );
  }
}
