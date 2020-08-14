import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp04/pages/cart_page.dart';
import 'package:flutterapp04/utils.dart';
import 'package:flutterapp04/widgets/list_item.dart';

import 'package:http/http.dart' as http;
import 'models/menu.dart';
import 'widgets/grid_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorBrightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

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

class MyHomePage extends StatefulWidget {
  final List<Menu> topCategoryList;

  const MyHomePage({Key key, this.topCategoryList}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> selectedList = List();
  List<TopCategoryData> subCategoryList = List();
  Menu selectedMenu;
  TopCategoryData categoryData;
  var itemView = Icons.list;

  @override
  void initState() {
    if (widget.topCategoryList != null && widget.topCategoryList.isNotEmpty) {
      selectedMenu = widget.topCategoryList[0];
      subCategoryList = selectedMenu.topCategoryData;
      if (subCategoryList != null && subCategoryList.isNotEmpty) {
        categoryData = subCategoryList[0];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Item> itemList = getItemList(widget.topCategoryList,
        selectedMenu.topCategoryId, categoryData.categoryDbId);

    Map<String, double> map = getSelectedTotalItemQty(selectedList);
    double count = map['count'] == null ? 0 : map['count'];

    var media = MediaQuery.of(context).size;
    var customRatio = media.width < 250 ? 1 : (media.width < 900 ? 1.2 : 0.8);

    // var customRatio = media.width < 250
    //     ? 0.8
    //     : (media.width < 700 ? 1.0 : (media.width < 900 ? 1.0 : 0.8));
    var customCardLimit = media.width < 900 ? 2 : 3;

    return Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                DropdownButton<Menu>(
                  value: selectedMenu,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (menu) {
                    setState(() {
                      selectedMenu = menu;
                      subCategoryList = List();
                      if (menu.topCategoryData.length > 1) {
                        subCategoryList.add(TopCategoryData(
                            category: "All Sub Category",
                            categoryDbId: -1,
                            categoryId: -1,
                            topCategoryId: -1));
                      }
                      subCategoryList.addAll(menu.topCategoryData);
                      categoryData = (subCategoryList != null &&
                              subCategoryList.isNotEmpty)
                          ? subCategoryList[0]
                          : null;
                    });
                  },
                  items: widget.topCategoryList
                      .map<DropdownMenuItem<Menu>>((Menu value) {
                    return DropdownMenuItem<Menu>(
                      value: value,
                      child: Text(value.topCategoryNameGivenByCustomer),
                    );
                  }).toList(),
                ),
                DropdownButton<TopCategoryData>(
                  value: categoryData,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (category) {
                    setState(() {
                      categoryData = category;
                    });
                  },
                  items: subCategoryList != null
                      ? subCategoryList.map<DropdownMenuItem<TopCategoryData>>(
                          (TopCategoryData value) {
                          return DropdownMenuItem<TopCategoryData>(
                            value: value,
                            child: Text(value.category),
                          );
                        }).toList()
                      : null,
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Menu List"),
          actions: <Widget>[
            IconButton(
              icon: Icon(itemView),
              onPressed: () {
                setState(() {
                  itemView = (itemView == Icons.view_comfy)
                      ? Icons.list
                      : Icons.view_comfy;
                });
              },
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  await navigateToShoppingCart(context, selectedList);
                  setState(() {});
                },
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () async {
                        await navigateToShoppingCart(context, selectedList);
                        setState(() {});
                      },
                    ),
                    Positioned(
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          count.toStringAsFixed(0),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.topCategoryList.length,
                itemBuilder: (BuildContext content, int index) {
                  return Card(
                    color: Colors.orange,
                    elevation: 10,
                    margin: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                          widget.topCategoryList[index]
                              .topCategoryNameGivenByCustomer,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            itemView == Icons.view_comfy
                ? Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
//                return Text(snapshot.data[index].itemName);
                        return Card(
                          margin: EdgeInsets.all(4),
                          child: ListItem(
                            item: itemList[index],
                            onTap: () {
                              setState(() {
                                addToCart(selectedList, itemList, index);
                              });
                            },
                          ),
                        );
                      },
                      itemCount: itemList.length,
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: itemList.length,
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: customRatio,
                        crossAxisCount: customCardLimit,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GridItem(
                          item: itemList[index],
                          onTap: () {
                            setState(() {
                              addToCart(selectedList, itemList, index);
                            });
                          },
                        );
                      },
                    ),
                  ),
          ],
        ));
  }
}

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

List<Item> getItemList(
    List<Menu> menuList, int topCategoryId, int subCategoryDBId) {
  List<Item> list = List();
  for (Menu menu in menuList) {
    if (menu.topCategoryData == null) {
      break;
    }
    if (topCategoryId == -1 || topCategoryId == menu.topCategoryId) {
      for (TopCategoryData topCategoryData in menu.topCategoryData) {
        if (topCategoryData.items == null) {
          break;
        }
        if (subCategoryDBId == -1 ||
            subCategoryDBId == topCategoryData.categoryDbId) {
          list.addAll(topCategoryData.items);
        }
      }
    }
  }
  return list;
}

List<DropdownMenuItem<Menu>> getTopCategoryList(List<Menu> menuList) {
  List<DropdownMenuItem<Menu>> dropList = List();
  for (Menu menu in menuList) {
    dropList.add(
      DropdownMenuItem(
        value: menu,
        child: Text("${menu.topCategoryNameGivenByCustomer}"),
      ),
    );
  }
  return dropList;
}

Future navigateToShoppingCart(
    BuildContext context, List<Item> selectedList) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => MyCartPage(currentOrderItemList: selectedList)),
  );
}

void addToCart(List<Item> selectedList, List<Item> itemList, int index) {
  var wasFound = false;
  for (Item item in selectedList) {
    if (itemList[index].itemCode == item.itemCode) {
      item.quantity++;
      wasFound = true;
    }
  }
  if (!wasFound) {
    var item = itemList[index];
    item.quantity = 1;
    selectedList.add(item);
  }
}
