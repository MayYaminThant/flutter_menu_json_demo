// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

List<Menu> menuFromJson(String str) => List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  Menu({
    this.topCategoryDbId,
    this.topCategoryId,
    this.topCategoryNameGivenByCustomer,
    this.topCategoryData,
    this.displayOrder,
  });

  int topCategoryDbId;
  int topCategoryId;
  String topCategoryNameGivenByCustomer;
  List<TopCategoryDatum> topCategoryData;
  int displayOrder;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    topCategoryDbId: json["topCategoryDBId"],
    topCategoryId: json["topCategoryId"],
    topCategoryNameGivenByCustomer: json["topCategoryNameGivenByCustomer"],
    topCategoryData: List<TopCategoryDatum>.from(json["topCategoryData"].map((x) => TopCategoryDatum.fromJson(x))),
    displayOrder: json["displayOrder"],
  );

  Map<String, dynamic> toJson() => {
    "topCategoryDBId": topCategoryDbId,
    "topCategoryId": topCategoryId,
    "topCategoryNameGivenByCustomer": topCategoryNameGivenByCustomer,
    "topCategoryData": List<dynamic>.from(topCategoryData.map((x) => x.toJson())),
    "displayOrder": displayOrder,
  };
}

class TopCategoryDatum {
  TopCategoryDatum({
    this.categoryId,
    this.categoryDbId,
    this.category,
    this.items,
    this.displayOrder,
    this.categoryFeatures,
    this.topCategoryId,
  });

  int categoryId;
  int categoryDbId;
  String category;
  List<Item> items;
  int displayOrder;
  CategoryFeatures categoryFeatures;
  int topCategoryId;

  factory TopCategoryDatum.fromJson(Map<String, dynamic> json) => TopCategoryDatum(
    categoryId: json["categoryId"],
    categoryDbId: json["categoryDBId"],
    category: json["category"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    displayOrder: json["displayOrder"],
    categoryFeatures: CategoryFeatures.fromJson(json["categoryFeatures"]),
    topCategoryId: json["topCategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryDBId": categoryDbId,
    "category": category,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "displayOrder": displayOrder,
    "categoryFeatures": categoryFeatures.toJson(),
    "topCategoryId": topCategoryId,
  };
}

class CategoryFeatures {
  CategoryFeatures({
    this.isClaimableByMemberPoints,
    this.isPointCollectEnabledByMember,
    this.isWeightVaryUnderAViss,
    this.isEffectedByPersonDiscount,
  });

  bool isClaimableByMemberPoints;
  bool isPointCollectEnabledByMember;
  bool isWeightVaryUnderAViss;
  bool isEffectedByPersonDiscount;

  factory CategoryFeatures.fromJson(Map<String, dynamic> json) => CategoryFeatures(
    isClaimableByMemberPoints: json["isClaimableByMemberPoints"],
    isPointCollectEnabledByMember: json["isPointCollectEnabledByMember"],
    isWeightVaryUnderAViss: json["isWeightVaryUnderAViss"],
    isEffectedByPersonDiscount: json["isEffectedByPersonDiscount"],
  );

  Map<String, dynamic> toJson() => {
    "isClaimableByMemberPoints": isClaimableByMemberPoints,
    "isPointCollectEnabledByMember": isPointCollectEnabledByMember,
    "isWeightVaryUnderAViss": isWeightVaryUnderAViss,
    "isEffectedByPersonDiscount": isEffectedByPersonDiscount,
  };
}

class Item {
  Item({
    this.id,
    this.itemName,
    this.itemDescription,
    this.itemPrice,
    this.photo,
    this.quantity,
    this.barcode,
    this.itemDbId,
    this.itemInfoList,
    this.averageBoughtPriceForOne,
    this.oneItemPrice,
    this.itemCode,
    this.itemType,
    this.oneItemDiscount,
    this.unit,
    this.additionalImages,
    this.topId,
    this.catId,
    this.extraWeightPerBucket,
    this.expression,
    this.orderItemInfoList,
    this.itemModifiers,
    this.staffList,
    this.itemPriceInfoList,
    this.itemAvailability,
    this.itemStatus,
    this.itemTag,
    this.systemTag,
    this.currencyType,
    this.displayOrder,
    this.uniqueId,
    this.ratio,
    this.unitDbId,
    this.promotionId,
    this.priceSetType,
    this.isUnitAutoChanged,
    this.sellBy,
    this.lastUpdatedTime,
    this.isOrderAutoMarge,
    this.margeItemDbId,
    this.isPromotedItem,
  });

  int id;
  String itemName;
  String itemDescription;
  double itemPrice;
  String photo;
  double quantity;
  String barcode;
  int itemDbId;
  ItemInfoList itemInfoList;
  double averageBoughtPriceForOne;
  double oneItemPrice;
  String itemCode;
  ItemType itemType;
  double oneItemDiscount;
  String unit;
  AdditionalImages additionalImages;
  int topId;
  int catId;
  double extraWeightPerBucket;
  String expression;
  List<dynamic> orderItemInfoList;
  List<dynamic> itemModifiers;
  List<dynamic> staffList;
  List<ItemPriceInfoList> itemPriceInfoList;
  ItemAvailability itemAvailability;
  ItemStatus itemStatus;
  String itemTag;
  ItemStatus systemTag;
  String currencyType;
  int displayOrder;
  String uniqueId;
  double ratio;
  int unitDbId;
  int promotionId;
  PriceSetType priceSetType;
  bool isUnitAutoChanged;
  SellBy sellBy;
  int lastUpdatedTime;
  bool isOrderAutoMarge;
  int margeItemDbId;
  bool isPromotedItem;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    itemName: json["item_name"],
    itemDescription: json["item_description"],
    itemPrice: json["item_price"],
    photo: json["photo"],
    quantity: json["quantity"],
    barcode: json["barcode"],
    itemDbId: json["itemDBId"],
    itemInfoList: ItemInfoList.fromJson(json["itemInfoList"]),
    averageBoughtPriceForOne: json["averageBoughtPriceForOne"],
    oneItemPrice: json["oneItemPrice"],
    itemCode: json["itemCode"],
    itemType: itemTypeValues.map[json["itemType"]],
    oneItemDiscount: json["oneItemDiscount"],
    unit: json["unit"],
    additionalImages: AdditionalImages.fromJson(json["additionalImages"]),
    topId: json["topId"],
    catId: json["catId"],
    extraWeightPerBucket: json["extraWeightPerBucket"].toDouble(),
    expression: json["expression"],
    orderItemInfoList: List<dynamic>.from(json["orderItemInfoList"].map((x) => x)),
    itemModifiers: List<dynamic>.from(json["itemModifiers"].map((x) => x)),
    staffList: List<dynamic>.from(json["staffList"].map((x) => x)),
    itemPriceInfoList: List<ItemPriceInfoList>.from(json["itemPriceInfoList"].map((x) => ItemPriceInfoList.fromJson(x))),
    itemAvailability: itemAvailabilityValues.map[json["itemAvailability"]],
    itemStatus: itemStatusValues.map[json["itemStatus"]],
    itemTag: json["itemTag"],
    systemTag: itemStatusValues.map[json["systemTag"]],
    currencyType: json["currencyType"],
    displayOrder: json["displayOrder"],
    uniqueId: json["uniqueId"],
    ratio: json["ratio"],
    unitDbId: json["unit_db_id"],
    promotionId: json["promotion_id"],
    priceSetType: priceSetTypeValues.map[json["priceSetType"]],
    isUnitAutoChanged: json["isUnitAutoChanged"],
    sellBy: sellByValues.map[json["sellBy"]],
    lastUpdatedTime: json["lastUpdatedTime"],
    isOrderAutoMarge: json["isOrderAutoMarge"],
    margeItemDbId: json["margeItemDBId"],
    isPromotedItem: json["isPromotedItem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_name": itemName,
    "item_description": itemDescription,
    "item_price": itemPrice,
    "photo": photo,
    "quantity": quantity,
    "barcode": barcode,
    "itemDBId": itemDbId,
    "itemInfoList": itemInfoList.toJson(),
    "averageBoughtPriceForOne": averageBoughtPriceForOne,
    "oneItemPrice": oneItemPrice,
    "itemCode": itemCode,
    "itemType": itemTypeValues.reverse[itemType],
    "oneItemDiscount": oneItemDiscount,
    "unit": unit,
    "additionalImages": additionalImages.toJson(),
    "topId": topId,
    "catId": catId,
    "extraWeightPerBucket": extraWeightPerBucket,
    "expression": expression,
    "orderItemInfoList": List<dynamic>.from(orderItemInfoList.map((x) => x)),
    "itemModifiers": List<dynamic>.from(itemModifiers.map((x) => x)),
    "staffList": List<dynamic>.from(staffList.map((x) => x)),
    "itemPriceInfoList": List<dynamic>.from(itemPriceInfoList.map((x) => x.toJson())),
    "itemAvailability": itemAvailabilityValues.reverse[itemAvailability],
    "itemStatus": itemStatusValues.reverse[itemStatus],
    "itemTag": itemTag,
    "systemTag": itemStatusValues.reverse[systemTag],
    "currencyType": currencyType,
    "displayOrder": displayOrder,
    "uniqueId": uniqueId,
    "ratio": ratio,
    "unit_db_id": unitDbId,
    "promotion_id": promotionId,
    "priceSetType": priceSetTypeValues.reverse[priceSetType],
    "isUnitAutoChanged": isUnitAutoChanged,
    "sellBy": sellByValues.reverse[sellBy],
    "lastUpdatedTime": lastUpdatedTime,
    "isOrderAutoMarge": isOrderAutoMarge,
    "margeItemDBId": margeItemDbId,
    "isPromotedItem": isPromotedItem,
  };
}

class AdditionalImages {
  AdditionalImages();

  factory AdditionalImages.fromJson(Map<String, dynamic> json) => AdditionalImages(
  );

  Map<String, dynamic> toJson() => {
  };
}

enum ItemAvailability { AVAILABLE }

final itemAvailabilityValues = EnumValues({
  "AVAILABLE": ItemAvailability.AVAILABLE
});

class ItemInfoList {
  ItemInfoList({
    this.history,
    this.remaining,
  });

  List<dynamic> history;
  List<dynamic> remaining;

  factory ItemInfoList.fromJson(Map<String, dynamic> json) => ItemInfoList(
    history: List<dynamic>.from(json["History"].map((x) => x)),
    remaining: List<dynamic>.from(json["Remaining"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "History": List<dynamic>.from(history.map((x) => x)),
    "Remaining": List<dynamic>.from(remaining.map((x) => x)),
  };
}

class ItemPriceInfoList {
  ItemPriceInfoList({
    this.label,
    this.price,
  });

  String label;
  double price;

  factory ItemPriceInfoList.fromJson(Map<String, dynamic> json) => ItemPriceInfoList(
    label: json["label"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "price": price,
  };
}

enum ItemStatus { NONE }

final itemStatusValues = EnumValues({
  "NONE": ItemStatus.NONE
});

enum ItemType { STOCK, NO_STOCK }

final itemTypeValues = EnumValues({
  "NO_STOCK": ItemType.NO_STOCK,
  "STOCK": ItemType.STOCK
});

enum PriceSetType { ORIGINAL }

final priceSetTypeValues = EnumValues({
  "ORIGINAL": PriceSetType.ORIGINAL
});

enum SellBy { DEFAULT }

final sellByValues = EnumValues({
  "DEFAULT": SellBy.DEFAULT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
