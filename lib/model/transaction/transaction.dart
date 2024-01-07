class Transaction {
  int id;
  String memberName;
  String date;
  double price;
  String coffeeName;
  List<String> addInName;

  Transaction(
      {required this.id,
      required this.memberName,
      required this.date,
      required this.price,
      required this.coffeeName,
      required this.addInName});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    dynamic priceValue = json['price'];

// Check the type of the value and convert it to double accordingly
    double priceDouble;
    if (priceValue is int) {
      // If it's an integer, directly convert it to double
      priceDouble = priceValue.toDouble();
    } else if (priceValue is double) {
      // If it's already a double, no conversion needed
      priceDouble = priceValue;
    } else {
      // Handle other cases or provide a default value
      throw Exception('Unexpected type for price: ${priceValue.runtimeType}');
    }
    return Transaction(
        id: json['id'],
        memberName: json['memberName'],
        price: priceDouble,
        addInName: (json['addInName'] as List<dynamic>)
            .map((item) => item.toString())
            .toList(),
        coffeeName: json['coffeeName'],
        date: json['date']);
  }
}
