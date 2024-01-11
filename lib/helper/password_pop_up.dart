import 'package:bislerium_cafe/features/login/registration.dart';
import 'package:bislerium_cafe/helper/store_service.dart';
import 'package:flutter/material.dart';

class PasswordPopUp {
  static void showPasswordPopUpDialog(BuildContext context) async {
    String password = (await StoreService.getPassword())!;
    TextEditingController textEditingController = TextEditingController();
    bool isPasswordWrong = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Enter your password for verification'),
              content: IntrinsicHeight(
                child: Column(
                  children: [
                    isPasswordWrong
                        ? Text('Password is incorrect',
                            style: TextStyle(color: Colors.red))
                        : Container(),
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (password == textEditingController.text) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        isPasswordWrong = true;
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    StoreService.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Logout', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
