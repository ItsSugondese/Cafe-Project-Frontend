import 'package:flutter/material.dart';

class ServiceHelper {
  static void showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }
}
