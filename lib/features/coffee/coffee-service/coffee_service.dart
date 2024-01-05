import 'dart:convert';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:bislerium_cafe/constants/module_name.dart';
import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:bislerium_cafe/model/coffee/coffee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoffeeService {
  static Future<List<Coffee>> getCoffee(BuildContext context) async {
    final response = await http
        .get(Uri.parse("${Backend.apiConstant}/${ModuleName.COFFEE}"));

    final Map<String, dynamic> responseBody = json.decode(response.body);

    List<Coffee> addInList = [];
    if (responseBody["status"] == 1) {
      List<dynamic> jsonDataList = responseBody['data'];

      for (var jsonData in jsonDataList) {
        Coffee coffee = Coffee.fromJson(jsonData);
        addInList.add(coffee);
      }
      return addInList;
    } else {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception("Hello");
    }
  }

  static Future<void> addCoffee(
      Map<String, dynamic> map, BuildContext context) async {
    //POST operation starts from here
    final response = await http.post(
      Uri.parse("${Backend.apiConstant}/${ModuleName.COFFEE}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody["status"] == 0) {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception(responseBody["message"]);
    }
  }

  static Future<void> deleteCoffee(int id, BuildContext context) async {
    //POST operation starts from here
    final response = await http.delete(
      Uri.parse("${Backend.apiConstant}/${ModuleName.COFFEE}/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody["status"] == 0) {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception(responseBody["message"]);
    }
  }
}
