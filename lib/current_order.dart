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
      home: CurrentOrderHome(
        currentOrderItemList: currentOrderItemList,
      ),
    );
  }
}

class CurrentOrderHome extends StatelessWidget {
  final List<Item> currentOrderItemList;

  const CurrentOrderHome({Key key, this.currentOrderItemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;
    return Scaffold(
        appBar: new AppBar(),
        body: Container(
          color: Colors.black12,
          child: ListView.builder(
            itemCount: currentOrderItemList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
//                  IconButton(
//                    iconSize: 40,
//                    icon: Icon(Icons.home),
//                    onPressed: () {},
//                  ),
                    Image.asset('assets/images/three_apples.jpg'),
                    Container(
                      height: 40,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 5, top: 3, right: 5, bottom: 3),
                      child: RaisedButton(
                          child: Text(currentOrderItemList[index].itemName)),
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 5, top: 3, right: 5, bottom: 3),
                      child: RaisedButton(
                        child: Text(currentOrderItemList[index]
                            .itemPrice
                            .toStringAsFixed(2)),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: size,
                          height: 40,
                          margin: const EdgeInsets.only(
                              left: 5, top: 3, right: 5, bottom: 3),
                          child: RaisedButton(
                              child: Icon(Icons.add,
                                  size: 25, color: Colors.white)),
                          color: Colors.lightBlue,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(
                                left: 5, top: 3, right: 5, bottom: 3),
                            child: RaisedButton(
                                child: Text(
                              currentOrderItemList[index]
                                  .quantity
                                  .toStringAsFixed(2),
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
                              left: 5, top: 3, right: 5, bottom: 3),
                          child: RaisedButton(
                              child: Icon(Icons.remove,
                                  size: 25, color: Colors.white)),
                          color: Colors.lightBlue,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
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
