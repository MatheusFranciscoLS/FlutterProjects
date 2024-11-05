import 'package:flutter/material.dart'; // Importa o pacote de Material Design do Flutter.
import 'package:provider/provider.dart'; // Importa o pacote Provider para gerenciamento de estado.
import 'model/task_model.dart'; // Importa o modelo de tarefas.
import 'todo_screen.dart'; // Importa a tela principal da lista de tarefas.

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskModel(), // Cria uma instância de TaskModel como um ChangeNotifier.
      child: const MyApp(), // O widget MyApp é o filho do ChangeNotifierProvider.
    ),
  );
}

// Classe principal da aplicação.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App', // Define o título da aplicação.
      home: TodoScreen(), // Define a tela inicial como TodoScreen.
    );
  }
}
