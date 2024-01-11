import 'dart:convert';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<bool> login(
      BuildContext context, Map<String, dynamic> map) async {
    //POST operation starts from here
    final response = await http.post(
      Uri.parse("${Backend.apiConstant}/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Check if the response body contains an error message
      final Map<String, dynamic> errorBody = json.decode(response.body);
      final errorMessage = errorBody['message'] as String;
      ServiceHelper.showErrorSnackBar(context, errorMessage);
      return false;
    }
  }

  static Future<bool> changePassword(
      BuildContext context, Map<String, dynamic> map) async {
    //POST operation starts from here
    final response = await http.post(
      Uri.parse("${Backend.apiConstant}/login/change-password"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Check if the response body contains an error message
      final Map<String, dynamic> errorBody = json.decode(response.body);
      final errorMessage = errorBody['message'] as String;
      ServiceHelper.showErrorSnackBar(context, errorMessage);
      return false;
    }
  }
}
