import 'package:flutter/material.dart';
import 'todo.dart';

void  main() => runApp(MaterialApp(
  title: 'Passing Data',
  home: TodoScreen(
    todos: List.generate(
      20, 
      (i) => Todo('Todo $i', 'A description of what needs to be done for Todo $i A description of what needs to be done for TodoA description of what needs to be done for TodoA description of what needs to be done for TodoA description of what needs to be done for TodoA description of what needs to be done for TodoA description of what needs to be done for Todo')
      ),
  ),
));


class TodoScreen extends StatelessWidget {

  final List<Todo> todos;

  TodoScreen({Key key, @required this.todos}) : super(key:key);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
        ),
        body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
              trailing: IconButton(
                icon: Icon(Icons.details),
                onPressed: () {
                  Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => DetailScreen(todo: todos[index]))
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => DetailScreen(todo: todos[index]))
                  );
              },
            );
          },
        ),
      );
    }
}

class DetailScreen extends StatelessWidget {
  
  final Todo todo;

  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(todo.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(todo.description),
        ),
      );
    }
}