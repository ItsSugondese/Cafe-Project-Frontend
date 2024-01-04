import 'dart:convert';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<AddIn>> getAddIn(BuildContext context) async {
  final response = await http.get(Uri.parse("${Backend.apiConstant}/addin"));

  final Map<String, dynamic> responseBody = json.decode(response.body);

  List<AddIn> addInList = [];
  if (responseBody["status"] == 1) {
    List<dynamic> jsonDataList = responseBody['data'];

    for (var jsonData in jsonDataList) {
      AddIn addIn = AddIn.fromJson(jsonData);
      addInList.add(addIn);
    }
    return addInList;
  } else {
    showErrorSnackBar(context, responseBody["message"]);
    throw Exception("Hello");
  }
}

Future<void> addAddIn(Map<String, dynamic> map, BuildContext context) async {
  //POST operation starts from here
  final response = await http.post(
    Uri.parse("${Backend.apiConstant}/addin"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(map),
  );

  final Map<String, dynamic> responseBody = json.decode(response.body);

  if (responseBody["status"] == 0) {
    showErrorSnackBar(context, responseBody["message"]);
    throw Exception(responseBody["message"]);
  }
}

void showErrorSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 3), // Adjust the duration as needed
    ),
  );
}
