import 'package:bislerium_cafe/model/addin/add_in.dart';

class Order {
  int id;
  String memberName;
  DateTime date;
  double price;
  int coffeeName;
  List<String> addInName;

  Order(
      {required this.id,
      required this.memberName,
      required this.date,
      required this.price,
      required this.coffeeName,
      required this.addInName});

  factory Order.fromJson(Map<String, dynamic> json) {
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
    return Order(
        id: json['id'],
        memberName: json['memberName'],
        price: priceDouble,
        addInName: json['addInName'],
        coffeeName: json['coffeeName'],
        date: json['date']);
  }
}
