import 'dart:convert';

import 'package:bislerium_cafe/constants/module_name.dart';
import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:bislerium_cafe/model/member/member.dart';
import 'package:bislerium_cafe/podo/member/member_request.dart';
import 'package:flutter/material.dart';

import '../../../constants/backend_constants.dart';
import 'package:http/http.dart' as http;

class MemberService {
  static Future<List<Member>> getMember(BuildContext context) async {
    final response = await http
        .get(Uri.parse("${Backend.apiConstant}/${ModuleName.MEMBER}"));

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

  static Future<Member?> getSingleMemberByContact(
      BuildContext context, String phoneNumber) async {
    final response = await http.get(Uri.parse(
        "${Backend.apiConstant}/${ModuleName.MEMBER}/contact/$phoneNumber"));

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody["status"] == 1) {
      Member? member = responseBody['data'] == null
          ? null
          : Member.fromJson(responseBody['data']);
      return member;
    } else {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception("Hello");
    }
  }

  static Future<Member> saveMember(
      BuildContext context, Map<String, dynamic> map) async {
    final response = await http.post(
      Uri.parse("${Backend.apiConstant}/${ModuleName.MEMBER}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody["status"] == 1) {
      return Member.fromJson(responseBody['data']);
    } else {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception(responseBody["message"]);
    }
  }
}
