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
    int count = 1;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'No',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Item Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Item Code',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Quantity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Unit',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Price',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: currentOrderItemList
                  .map(
                    (item) => DataRow(cells: [
                      DataCell(
                          Text('${count++}', style: TextStyle(fontSize: 16))),
                      DataCell(
                          Text(item.itemName, style: TextStyle(fontSize: 16))),
                      DataCell(
                          Text(item.itemCode, style: TextStyle(fontSize: 16))),
                      DataCell(Text(item.quantity.toStringAsFixed(2),
                          style: TextStyle(fontSize: 16))),
                      DataCell(Text(item.unit, style: TextStyle(fontSize: 16))),
                      DataCell(Text(item.itemPrice.toStringAsFixed(2),
                          style: TextStyle(fontSize: 16))),
                    ]),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
