import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Model/Post.dart';
import 'package:flutter/foundation.dart';


class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;

  Photo({this.id, this.title, this.thumbnailUrl});

  factory Photo.fromJSON(Map<String, dynamic> json) {
    return Photo(
      id: json["id"] as int,
      title: json["title"] as String,
      thumbnailUrl: json["thumbnailUrl"] as String
    );
  }
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
          .map<Photo>( (json) => Photo.fromJSON(json) )
          .toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('https://jsonplaceholder.typicode.com/photos');
  return compute(parsePhotos, response.body);
}

Future<Post> fetchPost() async {
  debugPrint("Loading data");
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  if (response.statusCode == 200) {
    debugPrint("Loading succeed");
    return Post.fromJSON(json.decode(response.body));
  } else {
    debugPrint("Loading failed");
    throw Exception('Failed to load post');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // final Future<Post> post;

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final"

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<List<Photo>>(
          future: fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData 
                  ? PhotosList(photos: snapshot.data)
                  : Center(child: CircularProgressIndicator(),);
          },
        ),
      );
    }
}

class PhotosList extends StatelessWidget {

  final List<Photo> photos;

  PhotosList({Key key, @required this.photos}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Image.network(photos[index].thumbnailUrl);
        },
      );
    }

}
