import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/visitor_registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Acesso de Visitantes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VisitorRegistrationScreen(),
    );
  }
}
