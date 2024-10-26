  import 'package:flutter/material.dart'; // Importa o pacote de Material Design do Flutter.
  import 'package:provider/provider.dart'; // Importa o pacote Provider para gerenciamento de estado.
  import 'model/task_model.dart'; // Importa o modelo de tarefas que contém a lógica de gerenciamento.

  class TodoScreen extends StatelessWidget {
    // Controlador para o campo de texto onde o usuário insere novas tarefas.
    final TextEditingController _controller = TextEditingController();

    @override
    Widget build(BuildContext context) {
      // Obtém a instância do TaskModel usando o Provider.
      final taskModel = Provider.of<TaskModel>(context);

      return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarefas'), // Título da barra de navegação.
        ),
        body: Column(
          children: [
            // Campo de entrada para novas tarefas.
            Padding(
              padding: const EdgeInsets.all(16.0), // Adiciona espaçamento ao redor do campo.
              child: TextField(
                controller: _controller, // Associa o controlador ao campo de texto.
                decoration: InputDecoration(
                  labelText: 'Nova Tarefa', // Texto que aparece acima do campo.
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add), // Ícone de adicionar.
                    onPressed: () {
                      // Ao pressionar o botão, verifica se o campo não está vazio.
                      if (_controller.text.isNotEmpty) {
                        taskModel.addTask(_controller.text); // Adiciona a nova tarefa ao modelo.
                        _controller.clear(); // Limpa o campo de texto.
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                // Constrói uma lista de tarefas dinamicamente.
                itemCount: taskModel.tasks.length, // Número de tarefas na lista.
                itemBuilder: (context, index) {
                  final task = taskModel.tasks[index]; // Obtém a tarefa atual.

                  return ListTile(
                    title: Text(
                      task.name, // Nome da tarefa a ser exibido.
                      style: TextStyle(
                        decoration: task.isDone ? TextDecoration.lineThrough : null, // Aplica um riscado se a tarefa estiver concluída.
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete), // Ícone de deletar.
                      onPressed: () => taskModel.removeTask(index), // Remove a tarefa ao pressionar o botão.
                    ),
                    onTap: () => taskModel.toggleTask(index), // Alterna o estado da tarefa ao clicar nela.
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
