import 'package:flutter/material.dart';

class OrderService {
  static Future<List<Order>> getMember(BuildContext context) async {
    final response = await http.get(Uri.parse("${Backend.apiConstant}/addin"));

    final Map<String, dynamic> responseBody = json.decode(response.body);

    List<Member> addInList = [];
    if (responseBody["status"] == 1) {
      List<dynamic> jsonDataList = responseBody['data'];

      for (var jsonData in jsonDataList) {
        Member member = Member.fromJson(jsonData);
        addInList.add(member);
      }
      return addInList;
    } else {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception("Hello");
    }
  }
}
