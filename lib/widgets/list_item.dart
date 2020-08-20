import 'package:flutter/material.dart';
import 'package:flutterapp04/models/menu.dart';
import 'package:flutterapp04/widgets/grid_item_add_button.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, @required this.item, @required this.onTap})
      : assert(item != null && onTap != null),
        super(key: key);

  final Item item;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage.assetNetwork(
        width: 70,
        fit: BoxFit.cover,
        placeholder: 'assets/images/apple.jpg',
        image: 'http://192.168.100.5:4907/tarabar/tarabar/resources/images/' +
            item.itemCode +
            '.jpg',
      ),
      title: priceWidget(item.itemPrice),
      subtitle: nameWidget(context, item.itemName),
      trailing: GridItemAddButton(
        onTap: onTap,
      ),
    );
  }
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
    style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
  );
}
