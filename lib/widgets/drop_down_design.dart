import 'package:flutter/material.dart';

class DropDownCustomButton extends StatelessWidget {
  const DropDownCustomButton({
    Key key,
    @required this.widget,
  })  : assert(widget != null),
        super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 300,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrangeAccent[100]),
          shape: BoxShape.rectangle,
        ),
        child: widget,
      ),
    );
  }
}
