import 'dart:typed_data';

import 'package:bislerium_cafe/features/coffee/add_coffee_screen.dart';
import 'package:bislerium_cafe/features/coffee/coffee-service/coffee_service.dart';
import 'package:bislerium_cafe/helper/drawer.dart';
import 'package:bislerium_cafe/helper/password_pop_up.dart';
import 'package:bislerium_cafe/model/coffee/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeScreen extends StatefulWidget {
  const CoffeeScreen({super.key});

  @override
  State<CoffeeScreen> createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  late Future<List<Coffee>> coffees;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PasswordPopUp.showPasswordPopUpDialog(context);
    coffees = CoffeeService.getCoffee(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee'),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddItemScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCoffeeScreen()),
          ).then((value) {
            setState(() {
              coffees = CoffeeService.getCoffee(context);
            });
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Coffee>>(
          future: coffees,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Coffee> listOfCoffee = snapshot.data ?? [];
              return Center(
                heightFactor: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    dataRowHeight: 200,
                    columnSpacing: 200,
                    columns: [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Price')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: listOfCoffee.map((coffeeMap) {
                      return DataRow(cells: [
                        DataCell(Image.memory(
                          coffeeMap.image ?? Uint8List(0),
                          width: 200,
                          fit: BoxFit.cover,
                        )),
                        DataCell(Text(coffeeMap.name)),
                        DataCell(Text("${coffeeMap.price}")),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddCoffeeScreen(
                                            coffee: coffeeMap,
                                          )),
                                ).then((value) {
                                  setState(() {
                                    coffees = CoffeeService.getCoffee(context);
                                  });
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteConfirmationDialog(
                                        context, coffeeMap.id)
                                    .then((value) {
                                  if (value) {
                                    setState(() {
                                      coffees =
                                          CoffeeService.getCoffee(context);
                                    });
                                  }
                                });
                              },
                            )
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [Text("${snapshot.error}")],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

Future<bool> _showDeleteConfirmationDialog(BuildContext context, int id) async {
  bool confirmDelete = false;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Confirmation'),
        content: Text('Are you sure you want to delete?'),
        actions: [
          TextButton(
            onPressed: () async {
              await CoffeeService.deleteCoffee(id, context);
              Navigator.of(context).pop(true); // Resolve the future with true
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Resolve the future with false
            },
            child: Text('No'),
          ),
        ],
      );
    },
  ).then((value) {
    confirmDelete = value ?? false;
  });

  return confirmDelete;
}
