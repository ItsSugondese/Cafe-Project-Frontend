import 'dart:convert';

import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:bislerium_cafe/model/member/member.dart';
import 'package:flutter/material.dart';

import '../../../constants/backend_constants.dart';
import 'package:http/http.dart' as http;

class MemberService {
  static Future<List<Member>> getMember(BuildContext context) async {
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
