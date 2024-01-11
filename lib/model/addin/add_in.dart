import 'dart:typed_data';

class AddIn {
  int id;
  String name;
  double price;
  Uint8List? image;

  AddIn({required this.id, required this.name, required this.price});

  factory AddIn.fromJson(Map<String, dynamic> json) {
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
    return AddIn(id: json['id'], name: json['name'], price: priceDouble);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['Name'] = name;
    data['Price'] = price;
    return data;
  }
}
