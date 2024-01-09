import 'package:bislerium_cafe/features/addins/addins_screen.dart';
import 'package:bislerium_cafe/features/coffee/add_coffee_screen.dart';
import 'package:bislerium_cafe/features/coffee/coffee_screen.dart';
import 'package:bislerium_cafe/features/login/registration.dart';
import 'package:bislerium_cafe/features/member/member_screen.dart';
import 'package:bislerium_cafe/features/orders/order_screen.dart';
import 'package:bislerium_cafe/features/payment/payment_screen.dart';
import 'package:bislerium_cafe/features/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OrderScreen(),
    );
  }
}
