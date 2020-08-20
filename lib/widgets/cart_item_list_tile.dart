import 'package:flutter/material.dart';
import 'package:flutterapp04/models/menu.dart';
import 'package:flutterapp04/widgets/cart_item_add_or_remove_button.dart';

class CartItemListTile extends StatelessWidget {
  const CartItemListTile({
    Key key,
    @required this.item,
    @required this.onQtyChanged,
  })  : assert(item != null),
        assert(onQtyChanged != null),
        super(key: key);

  final Item item;
  final ValueChanged<double> onQtyChanged;

  @override
  Widget build(BuildContext context) {
    return cartItem(context);
  }

  Widget cartItem(BuildContext context) {
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
                      nameWidget(context, item.itemName),
                      SizedBox(height: 8),
                      priceWidget(item.quantity * item.itemPrice),
                    ],
                  ),
                ),
                CartItemAddOrRemoveButton(
                  onQtyChanged: onQtyChanged,
                  quantity: item.quantity,
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
            child: imageWidget(item.itemCode),
          ),
        )
      ],
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
