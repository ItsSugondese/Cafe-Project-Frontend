import 'dart:convert';
import 'dart:io';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:bislerium_cafe/constants/module_name.dart';
import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:bislerium_cafe/model/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TransactionService {
  // static Future<List<Transa>> getOrder(BuildContext context) async {
  //   final response =
  //       await http.get(Uri.parse("${Backend.apiConstant}/${ModuleName.ORDER}"));

  //   final Map<String, dynamic> responseBody = json.decode(response.body);

  //   List<Order> addInList = [];
  //   if (responseBody["status"] == 1) {
  //     List<dynamic> jsonDataList = responseBody['data'];

  //     for (var jsonData in jsonDataList) {
  //       Order order = Order.fromJson(jsonData);
  //       addInList.add(order);
  //     }
  //     return addInList;
  //   } else {
  //     ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
  //     throw Exception("Hello");
  //   }
  // }

  static Future<bool> addTransaction(
      Map<String, dynamic> map, BuildContext context) async {
    //POST operation starts from here
    final response = await http.post(
      Uri.parse("${Backend.apiConstant}/${ModuleName.TRANSACTION}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody["status"] == 0) {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      return false;
    } else {
      return true;
    }
  }

  static Future<void> downloadPdf() async {
    //POST operation starts from here
    final response = await http.get(
        Uri.parse("${Backend.apiConstant}/${ModuleName.TRANSACTION}/doc/pdf"));

    final directory = await getApplicationDocumentsDirectory();
    final filePath = 'output.pdf';

    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    // Open the file using your preferred method (e.g., file.path)
    print('File downloaded to: ${file.path}');

    // final Map<String, dynamic> responseBody = json.decode(response.body);

    // if (responseBody["status"] == 0) {
    //   ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
    //   return false;
    // } else {
    //   return true;
    // }
  }

  static Future<List<Transaction>> getTransaction(BuildContext context) async {
    final response = await http
        .get(Uri.parse("${Backend.apiConstant}/${ModuleName.TRANSACTION}"));

    final Map<String, dynamic> responseBody = json.decode(response.body);

    List<Transaction> transactionList = [];
    if (responseBody["status"] == 1) {
      List<dynamic> jsonDataList = responseBody['data'];

      for (var jsonData in jsonDataList) {
        Transaction transaction = Transaction.fromJson(jsonData);
        transactionList.add(transaction);
      }
      return transactionList;
    } else {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception("Hello");
    }
  }
}
