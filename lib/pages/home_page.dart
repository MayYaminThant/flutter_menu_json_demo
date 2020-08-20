import 'package:flutter/material.dart';
import 'package:flutterapp04/models/menu.dart';
import 'package:flutterapp04/pages/cart_page.dart';
import 'package:flutterapp04/utils/utils.dart';
import 'package:flutterapp04/widgets/drop_down_design.dart';
import 'package:flutterapp04/widgets/grid_item.dart';
import 'package:flutterapp04/widgets/list_item.dart';

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
  List<Item> itemList;
  double count;
  var customRatio = 0.92;
  var customCardLimit = 2;

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
    itemList = getItemList(widget.topCategoryList, selectedMenu.topCategoryId,
        categoryData.categoryDbId);

    Map<String, double> map = getSelectedTotalItemQty(selectedList);
    count = map['count'] == null ? 0 : map['count'];
    var media = MediaQuery.of(context).size;
    customRatio = media.width < 250 ? 1 : (media.width < 900 ? 1.2 : 0.8);
    customCardLimit = media.width < 900 ? 2 : 3;

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              getTopCategoryDropDown(),
              getSubCategoryDropDown(),
            ],
          ),
        ),
      ),
      appBar: getAppBar(context, () {
        setState(
          () {
            itemView =
                (itemView == Icons.view_comfy) ? Icons.list : Icons.view_comfy;
          },
        );
      }),
      body: getBody(context),
    );
  }

  AppBar getAppBar(BuildContext context, VoidCallback onRefresh) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text("Menu List"),
      actions: <Widget>[
        IconButton(
          icon: Icon(itemView),
          onPressed: onRefresh,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              await navigateToShoppingCart(context);
              setState(() {});
            },
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () async {
                    await navigateToShoppingCart(context);
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
    );
  }

  Widget getBody(BuildContext context) {
    return itemView == Icons.view_comfy ? getListView() : getGridView();
  }

  Widget getListView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.all(4),
          child: ListItem(
            item: itemList[index],
            onTap: () {
              setState(() {
                addToCart(itemList, index);
              });
            },
          ),
        );
      },
      itemCount: itemList.length,
    );
  }

  Widget getGridView() {
    return GridView.builder(
      itemCount: itemList.length,
      physics: BouncingScrollPhysics(),
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: customRatio,
        crossAxisCount: customCardLimit,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GridItem(
          item: itemList[index],
          onTap: () {
            setState(() {
              addToCart(itemList, index);
            });
          },
        );
      },
    );
  }

  Widget getTopCategoryDropDown() {
    return DropDownCustomButton(
      widget: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Menu>(
            isExpanded: true,
            value: selectedMenu,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.deepOrangeAccent[100],
            ),
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
                categoryData =
                    (subCategoryList != null && subCategoryList.isNotEmpty)
                        ? subCategoryList[0]
                        : null;
              });
            },
            items: widget.topCategoryList
                .map<DropdownMenuItem<Menu>>((Menu value) {
              return DropdownMenuItem<Menu>(
                value: value,
                child: Text(
                  value.topCategoryNameGivenByCustomer,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget getSubCategoryDropDown() {
    return DropDownCustomButton(
      widget: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<TopCategoryData>(
            isExpanded: true,
            value: categoryData,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.deepOrangeAccent[100],
            ),
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
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          value.category,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black,),
                        ),
                      ),
                    );
                  }).toList()
                : null,
          ),
        ),
      ),
    );
  }

  Future navigateToShoppingCart(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyCartPage(currentOrderItemList: selectedList)),
    );
  }

  void addToCart(List<Item> itemList, int index) {
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
}
