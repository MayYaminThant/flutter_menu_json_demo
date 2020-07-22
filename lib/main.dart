import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'dart:convert' as convert;
//import 'package:http/http.dart' as http;
import 'models/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    fetchData(context);
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: ListView(
          padding: EdgeInsets.all(6),
          children: <Widget>[
            Container(
              color: Colors.amber[600],
              child: Text('AA'),
              height: 30,
            ),
            Container(
              color: Colors.amber[500],
              child: Text('BB'),
              height: 30,
            ),
            Container(
              color: Colors.amber[400],
              child: Text('CC'),
              height: 30,
            ),
          ],
        ));
  }
}

//void fetchData() async {
//  // This example uses the Google Books API to search for books about http.
//  // https://developers.google.com/books/docs/overview
//  var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
//
//  // Await the http get response, then decode the json-formatted response.
//  var response = await http.get(url);
//  if (response.statusCode == 200) {
//    List<Menu> menu = //convert.jsonDecode(response.body)
//        menuFromJson(response.body);
//    var itemCount = menu.length;
//    print('Number of books about http: $itemCount.');
//  } else {
//    print('Request failed with status: ${response.statusCode}.');
//  }
//}

Future<List<Menu>> fetchData(BuildContext context) async {
  List<Menu> menu = menuFromJson(
      await DefaultAssetBundle.of(context).loadString('assets/demo_menu.json'));

  return menu;
}
