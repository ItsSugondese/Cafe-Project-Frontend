class AddInRequest {
  int? id;
  String name;
  double price;
  int? fileId;

  AddInRequest({this.id, required this.name, required this.price, this.fileId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['Name'] = name;
    data['Price'] = price;
    data['fileId'] = fileId;
    return data;
  }
}
