import 'dart:convert';
import 'dart:typed_data';

import 'package:bislerium_cafe/constants/backend_constants.dart';
import 'package:bislerium_cafe/constants/module_name.dart';
import 'package:bislerium_cafe/helper/service_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchImageService {
  static Future<Uint8List> fetchBlobData(
      BuildContext context, int photoId, String module) async {
    try {
      final response = await http.get(
        Uri.parse("${Backend.apiConstant}/$module/doc/$photoId"),
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(response.bodyBytes);
      } else {
        String message = 'Failed to fetch blob data';
        final Map<String, dynamic> responseBody = json.decode(response.body);
        ServiceHelper.showErrorSnackBar(context, message);
        throw Exception(message);
      }
    } catch (e) {
      // Handle any other exceptions here
      ServiceHelper.showErrorSnackBar(context, 'Error fetching image: $e');
      rethrow; // Rethrow the exception to preserve the original stack trace
    }
  }
}
