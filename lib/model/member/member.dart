class Member {
  int id;
  String name;
  String phoneNumber;
  bool isMember;
  int coffeeCount;

  Member(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.isMember,
      required this.coffeeCount});

  factory Member.fromJson(Map<String, dynamic> json) {
//     dynamic priceValue = json['price'];

// // Check the type of the value and convert it to double accordingly
//     double priceDouble;
//     if (priceValue is int) {
//       // If it's an integer, directly convert it to double
//       priceDouble = priceValue.toDouble();
//     } else if (priceValue is double) {
//       // If it's already a double, no conversion needed
//       priceDouble = priceValue;
//     } else {
//       // Handle other cases or provide a default value
//       throw Exception('Unexpected type for price: ${priceValue.runtimeType}');
//     }
    return Member(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        isMember: json['isMember'],
        coffeeCount: json['coffeeCount']);
  }
}
