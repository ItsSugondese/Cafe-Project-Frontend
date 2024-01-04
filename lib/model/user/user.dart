class User {
  String? UserType;
  String Password;

  User({required this.UserType, required this.Password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(UserType: json['userType'], Password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userType'] = UserType;
    data['password'] = Password;
    return data;
  }
}
