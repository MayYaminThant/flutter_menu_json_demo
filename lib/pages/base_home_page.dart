import 'package:flutter/material.dart';
import 'package:flutterapp04/data/fetch_menu.dart';
import 'package:flutterapp04/models/menu.dart';

import 'home_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(context),
      builder: (BuildContext context, AsyncSnapshot<List<Menu>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.hasData) {
          return MyHomePage(topCategoryList: snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}