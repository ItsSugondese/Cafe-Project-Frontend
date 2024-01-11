import 'package:bislerium_cafe/features/login/login-service/login_service.dart';
import 'package:bislerium_cafe/features/login/registration.dart';
import 'package:bislerium_cafe/helper/drawer.dart';
import 'package:bislerium_cafe/helper/store_service.dart';
import 'package:bislerium_cafe/model/user/user.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  bool isPasswordWrong = false;
  bool isPasswordChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      drawer: MyDrawer(),
      body: IntrinsicHeight(
        child: Column(
          children: [
            isPasswordWrong
                ? Text('Password is incorrect',
                    style: TextStyle(color: Colors.red))
                : Container(),
            TextField(
              controller: oldPasswordController,
              decoration: InputDecoration(
                labelText: 'Enter Old Password',
              ),
            ),
            isPasswordChecked
                ? TextField(
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Enter New Password',
                    ),
                    onChanged: (val) {
                      setState(() {});
                    },
                  )
                : Container(),
            !isPasswordChecked
                ? ElevatedButton(
                    onPressed: () async {
                      if ((await StoreService.getPassword())! !=
                          oldPasswordController.text) {
                        setState(() {
                          isPasswordWrong = true;
                        });
                      } else {
                        setState(() {
                          isPasswordWrong = false;
                          isPasswordChecked = true;
                        });
                      }
                    },
                    child: Text("Check"))
                : Container(),
            isPasswordWrong == false
                ? ElevatedButton(
                    onPressed: newPasswordController.text.isEmpty
                        ? null
                        : () async {
                            String userType = (await StoreService.getRole())!;
                            User user = User(
                                UserType: userType,
                                Password: newPasswordController.text);
                            bool isSuccess = await LoginService.changePassword(
                                context, user.toJson());

                            if (isSuccess) {
                              StoreService.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            }
                          },
                    child: Text("Chnage"))
                : Container()
          ],
        ),
      ),
    );
  }
}
