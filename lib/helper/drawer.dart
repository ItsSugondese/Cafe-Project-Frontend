import 'package:bislerium_cafe/features/addins/addins_screen.dart';
import 'package:bislerium_cafe/features/coffee/coffee_screen.dart';
import 'package:bislerium_cafe/features/login/change_password.dart';
import 'package:bislerium_cafe/features/login/registration.dart';
import 'package:bislerium_cafe/features/member/member_screen.dart';
import 'package:bislerium_cafe/features/orders/order_screen.dart';
import 'package:bislerium_cafe/features/payment/payment_screen.dart';
import 'package:bislerium_cafe/features/transaction/transaction_screen.dart';
import 'package:bislerium_cafe/helper/store_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Future<String?> role;

  @override
  void initState() {
    super.initState();
    // Call an async method from within initState
    role = StoreService.getRole();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<String?>(
        future: role,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the role data
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error scenario
            return Text('Error: ${snapshot.error}');
          } else {
            // Role data has been fetched, build the drawer with the obtained role
            String obtainedRole =
                snapshot.data ?? ''; // Use an empty string if role is null
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    '${obtainedRole} window',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                if (obtainedRole.toUpperCase() == "ADMIN")
                  ListTile(
                    title: Text('Coffee Management'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CoffeeScreen()),
                      );
                    },
                  ),
                if (obtainedRole.toUpperCase() == "ADMIN")
                  ListTile(
                    title: Text('Add-Ins Management'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddInScreen()),
                      );
                    },
                  ),
                ListTile(
                  title: Text('Order'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OrderScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Member Management'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MemberScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Payment'),
                  onTap: () {
                    // Handle item 2 tap
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Transaction'),
                  onTap: () {
                    // Handle item 2 tap
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Change Password'),
                  onTap: () {
                    // Handle item 2 tap
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    StoreService.clear();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
