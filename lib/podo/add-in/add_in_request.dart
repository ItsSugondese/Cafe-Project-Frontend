class AddInRequest {
  int? id;
  String name;
  double price;

  AddInRequest({this.id, required this.name, required this.price});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['Name'] = name;
    data['Price'] = price;
    return data;
  }
}
