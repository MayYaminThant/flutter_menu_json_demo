import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp04/models/menu.dart';

import 'grid_item_add_button.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key key, @required this.item, @required this.onTap})
      : assert(item != null && onTap != null),
        super(key: key);

  final Item item;
  final GestureTapCallback onTap;

  static double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.width * 0.95 / 2.7;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            imageWidget(context),
            priceWidget(item.itemPrice),
            descriptionWidget(context, item.itemName),
          ],
        ),
      ),
    );
  }

  Widget imageWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: FadeInImage.assetNetwork(
            width: double.infinity,
            height: height,
            placeholder: 'assets/images/three_apples.jpg',
            image: 'http://tara-51:4907/tarabar/tarabar/resources/images/' +
                item.itemCode,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GridItemAddButton(
            onTap: onTap,
          ),
        ),
      ],
    );
  }

  Widget priceWidget(double amount) {
    return Text(
      amount.toStringAsFixed(0) + ' MMK',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget descriptionWidget(BuildContext context, String description) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption.copyWith(
            fontSize: 11,
          ),
    );
  }
}
