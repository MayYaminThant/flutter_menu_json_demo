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
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
//    Future<List<Item>> list = getItemList(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu List"),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                right: 4,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text('$count'),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: FutureBuilder(
        future: getItemList(context),
        builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
//                return Text(snapshot.data[index].itemName);
                return Card(
                  shadowColor: Colors.black54,
                  margin: EdgeInsets.all(4),
                  child: ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.fastfood,
                      color: Colors.blue,
                    ),
                    title: Text(
                      snapshot.data[index].itemName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      snapshot.data[index].itemPrice.toStringAsFixed(2),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          count++;
                        });
                      },
                      iconSize: 38,
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
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

Future<List<Item>> getItemList(BuildContext context) async {
  List<Item> list = List();
  List<Menu> menuList = await fetchData(context);
  for (Menu menu in menuList) {
    if (menu.topCategoryData == null) {
      break;
    }
    for (TopCategoryData topCategoryData in menu.topCategoryData) {
      if (topCategoryData.items == null) {
        break;
      }
      list.addAll(topCategoryData.items);
    }
  }
  return list;
}
