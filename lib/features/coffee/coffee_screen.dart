import 'package:bislerium_cafe/features/coffee/add_coffee_screen.dart';
import 'package:bislerium_cafe/features/coffee/coffee-service/coffee_service.dart';
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
    coffees = CoffeeService.getCoffee(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee'),
      ),
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
              return Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      Coffee coffee = snapshot.data![index];
                      return Row(
                        children: [
                          Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddCoffeeScreen(
                                          id: coffee.id,
                                          name: coffee.name,
                                          price: coffee.price)),
                                ).then((value) {
                                  setState(() {
                                    coffees = CoffeeService.getCoffee(context);
                                  });
                                });
                              },
                              child: SizedBox(
                                width: 300,
                                height: 100,
                                child: Column(children: [
                                  // menuWithImage.image != null
                                  //     ? Image.memory(
                                  //         menuWithImage.image ?? Uint8List(0),
                                  //         width: 100,
                                  //         height: 100,
                                  //         fit: BoxFit.cover,
                                  //       )
                                  //     : Image.asset(
                                  //         'assets/images/tuteelogo.png', // The path to the asset within your app
                                  //         width: 100,
                                  //         height: 100,
                                  //         fit: BoxFit.cover,
                                  //       ),
                                  Column(
                                    children: [
                                      Text(coffee.name),
                                      Text("Rs. ${coffee.price}"),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, coffee.id)
                                  .then((value) {
                                if (value) {
                                  setState(() {
                                    coffees = CoffeeService.getCoffee(context);
                                  });
                                }
                              });
                            },
                          )
                        ],
                      );
                    }),
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
