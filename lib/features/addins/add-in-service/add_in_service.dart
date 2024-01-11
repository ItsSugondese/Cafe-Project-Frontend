import 'dart:convert';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:bislerium_cafe/constants/module_name.dart';
import 'package:bislerium_cafe/helper/fetch_image.dart';
import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddInService {
  static Future<List<AddIn>> getAddIn(BuildContext context) async {
    final response = await http.get(Uri.parse("${Backend.apiConstant}/addin"));

    final Map<String, dynamic> responseBody = json.decode(response.body);

    List<AddIn> addInList = [];
    if (responseBody["status"] == 1) {
      List<dynamic> jsonDataList = responseBody['data'];

      for (var jsonData in jsonDataList) {
        AddIn addIn = AddIn.fromJson(jsonData);
        try {
          addIn.image = await FetchImageService.fetchBlobData(
              context, addIn.id, ModuleName.ADDIN);
        } catch (e) {
          print('Error fetching image: $e');
        }
        addInList.add(addIn);
      }
      return addInList;
    } else {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception("Hello");
    }
  }

  static Future<void> addAddIn(
      Map<String, dynamic> map, BuildContext context) async {
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
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception(responseBody["message"]);
    }
  }

  static Future<void> deleteAddIn(int id, BuildContext context) async {
    //POST operation starts from here
    final response = await http.delete(
      Uri.parse("${Backend.apiConstant}/addin/$id"),
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
