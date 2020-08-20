import 'package:flutter/material.dart';
import 'package:flutterapp04/models/menu.dart';
import 'package:flutterapp04/utils/utils.dart';
import 'package:flutterapp04/widgets/cart_item_list_tile.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key key, this.currentOrderItemList}) : super(key: key);

  final List<Item> currentOrderItemList;

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<Item> currentOrderItemList = List();
  double totalQty;
  double totalPrice;

  @override
  void initState() {
    currentOrderItemList = widget.currentOrderItemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> map = getSelectedTotalItemQty(currentOrderItemList);
    totalQty = map['count'] == null ? 0 : map['count'];
    totalPrice = map['price'] == null ? 0 : map['price'];

    return Scaffold(
      appBar: getAppBar(context),
      body: getBody(context),
    );
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Column(
      children: [
        /// item list
        Expanded(
          child: ListView.builder(
            itemCount: currentOrderItemList.length,
            itemBuilder: (BuildContext context, int index) {
              return CartItemListTile(
                item: currentOrderItemList[index],
                onQtyChanged: (quantity) {
                  if (quantity == 0) {
                    currentOrderItemList.removeAt(index);
                  } else {
                    currentOrderItemList[index].quantity = quantity;
                  }

                  setState(() {});
                },
              );
            },
          ),
        ),

        /// footer
        subTotalWidget(context, totalQty, totalPrice),
      ],
    );
  }

  Widget subTotalWidget(
      BuildContext context, double totalQty, double totalPrice) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: ${totalQty.toStringAsFixed(2)}'),
            Text('Sub Total: ${totalPrice.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
