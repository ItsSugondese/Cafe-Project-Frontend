import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _firstController = ScrollController();
  List<String> countries = [
    "Brazil",
    "Nepal",
    "India",
    "China",
    "USA",
    "Canada",
    "Canada",
    "Canada",
    "Canadfda",
    "Canfasfadsada",
    "Canada",
    "Canada",
    "Canasfdafada",
    "Cadasfnada",
    "Canada",
    "Canada",
    "Canada",
    "Canada",
    "Canada",
    "Canada",
    "Canada",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horizontal ListView"),
        backgroundColor: Colors.redAccent,
      ),
      body: Scrollbar(
        thumbVisibility: true, // Show the scrollbar always
        // controller: _firstController,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _firstController,
          children: countries.map((country) {
            return box(country, Colors.deepOrangeAccent);
          }).toList(),
        ),
      ),
    );
  }

  Widget box(String title, Color backgroundColor) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 80,
      height: 100, // Specify the height to match your design
      color: backgroundColor,
      alignment: Alignment.center,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
