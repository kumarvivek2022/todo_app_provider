import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/provider/todos.dart';
import '../model/todo.dart';
import '../page/edit_todo_page.dart';
import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    required this.todo,
  }) : super();

  @override
  Widget build(BuildContext context){
    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              label: 'Edit',
              onPressed: (_) => editTodo(context, todo),
          )
        ],),
        child: buildTodo(context),
        endActionPane: ActionPane(
        motion:const DrawerMotion(),
        children: [
          SlidableAction(
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (_) {
                  deleteTodo(context, todo);
                })
    ])
    );

  }



  Widget buildTodo(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColorDark,
                checkColor: Colors.red,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                  Provider.of<TodoProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);

                  Utils.showSnackBar(
                    context,
                    isDone ? 'Task completed' : 'Task marked incomplete',
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        fontSize: 22,
                      ),
                    ),

                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],

                ),
              ),
            ]
        ),
      ),
    );

  }
  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }


  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditTodoPage(todo: todo),
    ),
  );

}