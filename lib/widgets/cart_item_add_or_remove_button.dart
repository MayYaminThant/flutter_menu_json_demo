import 'package:flutter/material.dart';

class CartItemAddOrRemoveButton extends StatefulWidget {
  CartItemAddOrRemoveButton({
    Key key,
    @required this.onQtyChanged,
    this.quantity = 0,
  })  : assert(onQtyChanged != null),
        super(key: key);

  final ValueChanged<double> onQtyChanged;
  final double quantity;

  @override
  _CartItemAddOrRemoveButtonState createState() =>
      _CartItemAddOrRemoveButtonState();
}

class _CartItemAddOrRemoveButtonState extends State<CartItemAddOrRemoveButton> {
  double quantity;

  @override
  Widget build(BuildContext context) {
    quantity = widget.quantity;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrangeAccent[100]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        elevation: 0,
        child: Row(
          children: [
            actionButtonWidget(() {
              setState(
                () {
                  quantity--;
                  widget.onQtyChanged(quantity);
                },
              );
            }, Icon(Icons.remove)),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Text(
                quantity.toStringAsFixed(0),
                style: TextStyle(
                  color: Colors.deepOrangeAccent[100],
                  fontSize: 16,
                ),
              ),
            ),
            actionButtonWidget(() {
              setState(
                () {
                  quantity++;
                  widget.onQtyChanged(quantity);
                },
              );
            }, Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}

Widget actionButtonWidget(GestureTapCallback onTap, Icon icon) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: icon,
    ),
  );
}
