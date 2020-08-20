import 'package:flutter/material.dart';
import 'package:flutterapp04/models/menu.dart';
import 'package:http/http.dart' as http;

Future<List<Menu>> fetchData(BuildContext context) async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url = 'http://192.168.100.5:4907/tarabar/public/stockReport.json';

  // Await the http get response, then decode the json-formatted response.
  List<Menu> menuList = List();
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      menuList = menuFromJson(response.body);
      var itemCount = menuList.length;
      print('Number of menu about http: $itemCount.');
    } else {
      throw Exception('Failed to load menu');
    }
  } catch (e) {
    print(e);
    menuList = menuFromJson(await DefaultAssetBundle.of(context)
        .loadString('assets/demo_menu.json'));
  }
  menuList.insert(
      0,
      Menu(
          topCategoryNameGivenByCustomer: "All Top Category",
          topCategoryDbId: -1,
          topCategoryId: -1,
          topCategoryData: [
            TopCategoryData(
                category: "All Sub Category",
                categoryDbId: -1,
                categoryId: -1,
                topCategoryId: -1)
          ]));
  return menuList;
}
