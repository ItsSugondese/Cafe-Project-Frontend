import 'dart:convert';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<void> login(Map<String, dynamic> map) async {
  //POST operation starts from here
  final response = await http.post(
    Uri.parse("${Backend.apiConstant}/login"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(map),
  );

  if (response.statusCode == 200) {
    print("Hello tere");
  } else {
    // Check if the response body contains an error message
    final Map<String, dynamic> errorBody = json.decode(response.body);
    final errorMessage = errorBody['error'] as String;
    throw Exception(errorMessage ?? "Unknown error");
  }
}
