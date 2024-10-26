import 'package:flutter/material.dart'; // Importa o pacote de Material Design do Flutter.

class Task {
  final String name; // Nome da tarefa, que não pode ser alterado após a criação.
  bool isDone; // Estado da tarefa: se está concluída ou não.

  // Construtor da classe Task. 'required' indica que o parâmetro 'name' é obrigatório.
  Task({required this.name, this.isDone = false});
}

// Classe que gerencia a lista de tarefas, estendendo ChangeNotifier para notificar mudanças.
class TaskModel with ChangeNotifier {
  List<Task> _tasks = []; // Lista privada que armazena as tarefas.oo

  // Getter para acessar a lista de taroefas.
  List<Task> get tasks => _tasks;

  // Método para adicionar uma nova tarefa à lista.
  void addTask(String taskName) {
    _tasks.add(Task(name: taskName)); // Cria uma nova tarefa e a adiciona à lista.
    notifyListeners(); // Notifica ouvintes de que o estado mudou.
  }

  // Método para alternar o estado de uma tarefa (concluída ou não).
  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone; // Inverte o estado da tarefa.
    notifyListeners(); // Notifica ouvintes da mudança de estado.
  }

  // Método para remover uma tarefa da lista.
  void removeTask(int index) {
    _tasks.removeAt(index); // Remove a tarefa no índice especificado.
    notifyListeners(); // Notifica ouvintes de que o estado mudou.
  }
}
