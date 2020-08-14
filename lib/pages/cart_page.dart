import 'package:flutter/material.dart';
import 'package:flutterapp04/models/menu.dart';
import 'package:flutterapp04/utils.dart';
import 'package:flutterapp04/widgets/cart_item_add_or_remove_button.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key key, this.currentOrderItemList}) : super(key: key);

  final List<Item> currentOrderItemList;

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<Item> currentOrderItemList = List();

  @override
  void initState() {
    currentOrderItemList = widget.currentOrderItemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> map = getSelectedTotalItemQty(currentOrderItemList);
    double totalQty = map['count'] == null ? 0 : map['count'];
    double totalPrice = map['price'] == null ? 0 : map['price'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
//      body: bodyWidget(context, currentOrderItemList),
      body: Column(
        children: [
          /// item list
          Expanded(
            child: ListView.builder(
              itemCount: currentOrderItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(left: 30),
                      height: 100,
                      child: Card(
                        elevation: 3,
                        child: Row(
                          children: [
                            SizedBox(width: 35),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                nameWidget(context,
                                    currentOrderItemList[index].itemName),
                                SizedBox(height: 8),
                                priceWidget(
                                    currentOrderItemList[index].quantity *
                                        currentOrderItemList[index].itemPrice),
                              ],
                            )),
                            CartItemAddOrRemoveButton(
                              onQtyChanged: (quantity) {
                                if (quantity == 0) {
                                  currentOrderItemList.removeAt(index);
                                } else {
                                  currentOrderItemList[index].quantity =
                                      quantity;
                                }
                                setState(() {});
                              },
                              quantity: currentOrderItemList[index].quantity,
                            ),
                            SizedBox(width: 15),
                          ],
                        ), //
                      ),
                    ),
                    Positioned(
                      top: 14,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child:
                            imageWidget(currentOrderItemList[index].itemCode),
                      ),
                    )
                  ],
                );
              },
            ),
          ),

          /// footer
          subTotalWidget(context, totalQty, totalPrice),
        ],
      ),
    );
  }
}

Widget imageWidget(String itemCode) {
  return FadeInImage.assetNetwork(
    width: 70,
    height: 70,
    fit: BoxFit.cover,
    placeholder: 'assets/images/apple.jpg',
    image: 'http://192.168.100.5:4907/tarabar/tarabar/resources/images/' +
        itemCode +
        '.jpg',
  );
}

Widget priceWidget(double price) {
  return Text(
    price.toStringAsFixed(0) + ' MMK',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget nameWidget(BuildContext context, String name) {
  return Text(
    name,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(context).textTheme.caption.copyWith(
          fontSize: 11,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
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
