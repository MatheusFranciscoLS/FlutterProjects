# Tutorial: Criando uma Aplicação de Lista de Tarefas em Flutter

## Objetivo
Neste tutorial, você aprenderá a criar uma aplicação simples de lista de tarefas onde o usuário pode adicionar, remover e marcar tarefas como concluídas.

## Pré-requisitos
- Flutter instalado em sua máquina.
- Conhecimentos básicos de Dart e Flutter.

## Passos

1. **Criar um Novo Projeto Flutter**
   - Abra seu terminal ou prompt de comando.
   - Crie um novo projeto Flutter com o seguinte comando:
     ```bash
     flutter create todo_app
     ```
   - Navegue até a pasta do projeto:
     ```bash
     cd todo_app
     ```

2. **Adicionar Dependência do Provider**
   - Abra o arquivo `pubspec.yaml`.
   - Adicione a dependência `provider` na seção de dependências:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       provider: ^6.0.0
     ```
   - Salve o arquivo e execute o comando para instalar as dependências:
     ```bash
     flutter pub get
     ```

3. **Criar o Modelo de Tarefa**
   - Crie uma nova pasta chamada `model` dentro da pasta `lib`.
   - Dentro da pasta `model`, crie um arquivo chamado `task_model.dart`.
   - Adicione o seguinte código ao `task_model.dart`:
     ```dart
     import 'package:flutter/material.dart';

     class Task {
       final String name;
       bool isDone;

       Task({required this.name, this.isDone = false});
     }

     class TaskModel with ChangeNotifier {
       List<Task> _tasks = [];

       List<Task> get tasks => _tasks;

       void addTask(String taskName) {
         _tasks.add(Task(name: taskName));
         notifyListeners();
       }

       void toggleTask(int index) {
         _tasks[index].isDone = !_tasks[index].isDone;
         notifyListeners();
       }

       void removeTask(int index) {
         _tasks.removeAt(index);
         notifyListeners();
       }
     }
     ```

4. **Criar a Tela Principal**
   - Crie um novo arquivo chamado `todo_screen.dart` dentro da pasta `lib`.
   - Adicione o seguinte código ao `todo_screen.dart`:
     ```dart
     import 'package:flutter/material.dart';
     import 'package:provider/provider.dart';
     import 'model/task_model.dart';

     class TodoScreen extends StatelessWidget {
       final TextEditingController _controller = TextEditingController();

       @override
       Widget build(BuildContext context) {
         final taskModel = Provider.of<TaskModel>(context);

         return Scaffold(
           appBar: AppBar(
             title: Text('Lista de Tarefas'),
           ),
           body: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: TextField(
                   controller: _controller,
                   decoration: InputDecoration(
                     labelText: 'Nova Tarefa',
                     suffixIcon: IconButton(
                       icon: Icon(Icons.add),
                       onPressed: () {
                         if (_controller.text.isNotEmpty) {
                           taskModel.addTask(_controller.text);
                           _controller.clear();
                         }
                       },
                     ),
                   ),
                 ),
               ),
               Expanded(
                 child: ListView.builder(
                   itemCount: taskModel.tasks.length,
                   itemBuilder: (context, index) {
                     final task = taskModel.tasks[index];

                     return ListTile(
                       title: Text(
                         task.name,
                         style: TextStyle(
                           decoration: task.isDone ? TextDecoration.lineThrough : null,
                         ),
                       ),
                       trailing: IconButton(
                         icon: Icon(Icons.delete),
                         onPressed: () => taskModel.removeTask(index),
                       ),
                       onTap: () => taskModel.toggleTask(index),
                     );
                   },
                 ),
               ),
             ],
           ),
         );
       }
     }
     ```

5. **Configurar o Widget Principal**
   - Abra o arquivo `main.dart`.
   - Modifique o código para configurar o Provider e exibir a tela principal:
     ```dart
     import 'package:flutter/material.dart';
     import 'package:provider/provider.dart';
     import 'model/task_model.dart';
     import 'todo_screen.dart';

     void main() {
       runApp(
         ChangeNotifierProvider(
           create: (context) => TaskModel(),
           child: MyApp(),
         ),
       );
     }

     class MyApp extends StatelessWidget {
       @override
       Widget build(BuildContext context) {
         return MaterialApp(
           title: 'To-Do List App',
           home: TodoScreen(),
         );
       }
     }
     ```

6. **Executar a Aplicação**
   - Conecte um dispositivo ou inicie um emulador.
   - No terminal, execute o comando:
     ```bash
     flutter run
     ```
   - A aplicação deve abrir, permitindo que você adicione, remova e marque tarefas como concluídas.

## Conclusão
Parabéns! Você criou uma aplicação de lista de tarefas simples utilizando Flutter e o pacote Provider para gerenciamento de estado. Agora você pode expandir essa aplicação adicionando novas funcionalidades conforme desejar.
