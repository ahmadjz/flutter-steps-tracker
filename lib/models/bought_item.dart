class BoughtItem {
  BoughtItem(
      {required this.date,
      required this.itemId,
      required this.itemName,
      required this.itemCost});
  final String date;
  final String itemId;
  final String itemName;
  final int itemCost;

  factory BoughtItem.fromMap(Map<String, dynamic> data) {
    final String date = data['date'];
    final String itemId = data['itemId'];
    final String itemName = data['itemName'];
    final int itemCost = data['itemCost'];
    return BoughtItem(
        date: date, itemId: itemId, itemName: itemName, itemCost: itemCost);
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "itemId": itemId,
      "itemName": itemName,
      "itemCost": itemCost
    };
  }
}
