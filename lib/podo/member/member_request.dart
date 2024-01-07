class MemberRequest {
  int? id;
  String name;
  String phoneNumber;

  MemberRequest({
    this.id,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['Name'] = name;
    data['PhoneNumber'] = phoneNumber;
    return data;
  }
}
