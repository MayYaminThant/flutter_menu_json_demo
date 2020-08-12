import 'package:flutter/material.dart';

class GridItemAddButton extends StatelessWidget {
  const GridItemAddButton({
    Key key,
    @required this.onTap,
  })  : assert(onTap != null),
        super(key: key);

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrangeAccent[100]),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add, color: Colors.deepOrangeAccent[100]),
        ),
      ),
    );
  }
}
