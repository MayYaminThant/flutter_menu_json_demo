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

List<Item> getItemList(
    List<Menu> menuList, int topCategoryId, int subCategoryDBId) {
  List<Item> list = List();
  for (Menu menu in menuList) {
    if (menu.topCategoryData == null) {
      break;
    }
    if (topCategoryId == -1 || topCategoryId == menu.topCategoryId) {
      for (TopCategoryData topCategoryData in menu.topCategoryData) {
        if (topCategoryData.items == null) {
          break;
        }
        if (subCategoryDBId == -1 ||
            subCategoryDBId == topCategoryData.categoryDbId) {
          list.addAll(topCategoryData.items);
        }
      }
    }
  }
  return list;
}
