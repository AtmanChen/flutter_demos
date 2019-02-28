
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:developer';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: "Flutter Demo",
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "new_page": (context) => new NewRoute(),
        },
        home: new MyHomePage(),
      );
    }
}


class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
          _counter++;
          debugger(when: _counter > 1);
    });
  }


  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Like the wind!"),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'You have pushed the button this many times:',
              ),
              new Text(
                '$_counter',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: Theme.of(context).textTheme.display1.fontSize,
                ),
              ),
              new FlatButton(
                child: Text("route to a new page"),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, "new_page");
                },
              ),
              new RandomWordsWidget(),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: new Icon(Icons.adb),
        ),
      );
    }
}

class NewRoute extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text("New Route"),
        ),
        body: Center(
          child: Text("This is a new route"),
        ),
      );
    }
}


class RandomWordsWidget extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      final wordPair = new WordPair.random();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(wordPair.toString()),
      );
    }
}