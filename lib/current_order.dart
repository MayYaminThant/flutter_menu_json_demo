import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/menu.dart';

class CurrentOrder extends StatelessWidget {
  final List<Item> currentOrderItemList;

  const CurrentOrder({Key key, this.currentOrderItemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyStateHomePage(
        currentOrderItemList: currentOrderItemList,
      ),
    );
  }
}

class MyStateHomePage extends StatefulWidget {
  final List<Item> currentOrderItemList;

  const MyStateHomePage({Key key, this.currentOrderItemList}) : super(key: key);

  @override
  _CurrentOrderHome createState() => _CurrentOrderHome();
}

class _CurrentOrderHome extends State<MyStateHomePage> {
  List<Item> currentOrderItemList = List();

  @override
  void initState() {
    currentOrderItemList = widget.currentOrderItemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: new AppBar(),
        body: ListView.builder(
          itemCount: currentOrderItemList.length,
          itemBuilder: (BuildContext context, int index) {
            double itemQuantity = currentOrderItemList[index].quantity;
            return Card(
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
//                  Image.asset('assets/images/three_apples.jpg'),
                  FadeInImage.assetNetwork(
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                    placeholder: 'assets/images/three_apples.jpg',
                    image:
                        'http://tara-51:4907/tarabar/tarabar/resources/images/' +
                            currentOrderItemList[index].itemCode,
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        left: 5, top: 3, right: 5, bottom: 3),
                    child: RaisedButton(
                        color: Colors.lightBlueAccent,
                        onPressed: () {},
                        child: Text(currentOrderItemList[index].itemName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        left: 5, top: 3, right: 5, bottom: 3),
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      onPressed: () {},
                      child: Text(
                          currentOrderItemList[index]
                              .itemPrice
                              .toStringAsFixed(2),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: size,
                        height: 40,
                        margin: const EdgeInsets.only(
                            left: 5, top: 3, right: 5, bottom: 8),
                        child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () {
                              setState(() {
                                currentOrderItemList[index].quantity++;
                              });
                            },
                            child:
                                Icon(Icons.add, size: 25, color: Colors.white)),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.only(
                              left: 5, top: 3, right: 5, bottom: 8),
                          child: RaisedButton(
                              color: Colors.orangeAccent,
                              onPressed: () {},
                              child: Text(
                                itemQuantity.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                        ),
                      ),
                      Container(
                        width: size,
                        height: 40,
                        margin: const EdgeInsets.only(
                            left: 5, top: 3, right: 5, bottom: 8),
                        child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () {
                              setState(() {
                                if (itemQuantity == 1) {
                                  currentOrderItemList
                                      .remove(currentOrderItemList[index]);
                                } else {
                                  currentOrderItemList[index].quantity--;
                                }
                              });
                            },
                            child: Icon(Icons.remove,
                                size: 25, color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}

//class CurrentOrderHome extends StatelessWidget {
//  final List<Item> currentOrderItemList;
//
//  const CurrentOrderHome({Key key, this.currentOrderItemList})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    int count = 1;
//    return Scaffold(
//      body: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Container(
//          child: SingleChildScrollView(
//            scrollDirection: Axis.horizontal,
//            child: DataTable(
//              columns: const <DataColumn>[
//                DataColumn(
//                  label: Text(
//                    'No',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                DataColumn(
//                  label: Text(
//                    'Item Name',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                DataColumn(
//                  label: Text(
//                    'Item Code',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                DataColumn(
//                  label: Text(
//                    'Quantity',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                DataColumn(
//                  label: Text(
//                    'Unit',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                DataColumn(
//                  label: Text(
//                    'Price',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                ),
//              ],
//              rows: currentOrderItemList
//                  .map(
//                    (item) => DataRow(cells: [
//                      DataCell(
//                          Text('${count++}', style: TextStyle(fontSize: 16))),
//                      DataCell(
//                          Text(item.itemName, style: TextStyle(fontSize: 16))),
//                      DataCell(
//                          Text(item.itemCode, style: TextStyle(fontSize: 16))),
//                      DataCell(Text(item.quantity.toStringAsFixed(2),
//                          style: TextStyle(fontSize: 16))),
//                      DataCell(Text(item.unit, style: TextStyle(fontSize: 16))),
//                      DataCell(Text(item.itemPrice.toStringAsFixed(2),
//                          style: TextStyle(fontSize: 16))),
//                    ]),
//                  )
//                  .toList(),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
