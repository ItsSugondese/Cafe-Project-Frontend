class AddIn {
  int id;
  String name;
  double price;

  AddIn({required this.id, required this.name, required this.price});

  factory AddIn.fromJson(Map<String, dynamic> json) {
    return AddIn(id: json['id'], name: json['name'], price: json['price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['Name'] = name;
    data['Price'] = price;
    return data;
  }
}
