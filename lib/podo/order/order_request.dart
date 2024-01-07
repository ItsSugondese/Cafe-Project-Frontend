class OrderRequest {
  int? id;
  int memberId;
  bool hadDiscount;
  bool wasRedeem;
  double price;
  int coffeeId;
  bool hadAddIn;
  int? redeemId;
  List<int> addInsId;

  OrderRequest(
      {this.id,
      required this.memberId,
      required this.hadDiscount,
      required this.wasRedeem,
      required this.price,
      required this.coffeeId,
      required this.hadAddIn,
      this.redeemId,
      required this.addInsId});

  // Factory method to convert an Order instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'hadDiscount': hadDiscount,
      'wasRedeem': wasRedeem,
      'price': price,
      'coffeeId': coffeeId,
      'hadAddIn': hadAddIn,
      'redeemId': redeemId,
      'AddInsId': addInsId
    };
  }
}
