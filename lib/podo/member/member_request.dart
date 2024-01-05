class MemberRequest {
  int? id;
  String name;
  String phoneNumber;
  bool isMember;
  int coffeeCount;

  MemberRequest(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.isMember,
      required this.coffeeCount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['Name'] = name;
    data['PhoneNumber'] = phoneNumber;
    data['IsMember'] = isMember;
    data['CoffeeCount'] = coffeeCount;
    return data;
  }
}
