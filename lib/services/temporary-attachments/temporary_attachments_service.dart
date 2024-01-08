import 'dart:convert';
import 'dart:io';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:bislerium_cafe/constants/module_name.dart';
import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:bislerium_cafe/model/orders/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TemporaryAttachmentsService {
  static Future<int> getAttachmentId(BuildContext context) async {
    final response =
        await http.get(Uri.parse("${Backend.apiConstant}/${ModuleName.ORDER}"));

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody["status"] == 1) {
      List<dynamic> jsonDataList = responseBody['data'];

      return jsonDataList[0];
    } else {
      ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
      throw Exception("Hello");
    }
  }

  static Future<int> uploadFile(File file, BuildContext context) async {
    //POST operation starts from here
    var url =
        Uri.parse("${Backend.apiConstant}/${ModuleName.TEMPORARY_ATTACHMENTS}");

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add the file to the request
    var fileStream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile('attachments', fileStream, length,
        filename: file.path);

    // Add the file to the request
    request.files.add(multipartFile);

    try {
      // Send the request
      var streamedResponse = await request.send();

      // Convert the StreamedResponse to a regular Response
      var response = await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody["status"] == 1) {
        List<dynamic> jsonDataList = responseBody['data'];

        return jsonDataList[0];
      } else {
        ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
        throw Exception("Hello");
      }
    } catch (error) {
      // Handle the exception
      ServiceHelper.showErrorSnackBar(context, 'Error uploading file: $error');
      throw Exception('Error uploading file: $error');
    }
  }
}
