import 'package:flutterapp04/models/menu.dart';

Map<String, double> getSelectedTotalItemQty(List<Item> itemList) {
  double count = 0;
  double price = 0;
  Map<String, double> map = Map();
  for (Item item in itemList) {
    count += item.quantity;
    price += item.quantity * item.itemPrice;
    map = {'count': count, 'price': price};
  }
  return map;
}
