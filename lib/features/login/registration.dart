import 'package:bislerium_cafe/enums/role.dart';
import 'package:bislerium_cafe/features/login/login-service/login_service.dart';
import 'package:bislerium_cafe/model/user/user.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String? errorMessage;
  String? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Column(
        children: <Widget>[
          Text(errorMessage ?? ''),
          Text(selected ?? ''),
          Expanded(
            child: Container(
              height: 100,
              width: 100,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.brown, fontSize: 20),
                    ),
                    Text(
                      ' SIGN UP',
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  color: Colors.brown[50],
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: DropdownMenu<String>(
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          this.selected = value;
                        });
                      },
                      hintText: "Select your role",
                      dropdownMenuEntries: Roles.values
                          .map((e) => e.toString().split('.').last)
                          .toList()
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  color: Colors.brown[50],
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: passwordEditingController,
                      decoration:
                          const InputDecoration(labelText: "Enter Password"),
                    ),
                  ),
                ),
                Container(
                  color: Colors.brown[50],
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (selected == null ||
                                passwordEditingController.text
                                    .toString()
                                    .isEmpty) {
                              errorMessage = "TExt is empty";
                            } else {
                              errorMessage = null;
                              // Navigator.of(context).push(
                              // MaterialPageRoute(
                              // builder: (context) =>
                              // const SongScreen(song: song),
                              // ),
                              // );

                              User user = User(
                                  UserType: selected,
                                  Password: passwordEditingController.text);

                              login(user.toJson());
                            }
                          });
                        },
                        child: const Text("Login")),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
