import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/model/todo.dart';
import 'package:todo_app_provider/widget/todo_widget.dart';

import '../provider/todos.dart';


class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? const Center(
      child: Text(
        'No todos.',
        style: TextStyle(fontSize: 20),
      ),
    )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(height: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return TodoWidget(todo: todo);
      },
    );


  }
}