import 'package:bislerium_cafe/features/addins/add_addins_screen.dart';
import 'package:bislerium_cafe/features/addins/add-in-service/add_in_service.dart';
import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:flutter/material.dart';

class AddInScreen extends StatefulWidget {
  const AddInScreen({super.key});

  @override
  State<AddInScreen> createState() => _AddInScreenState();
}

class _AddInScreenState extends State<AddInScreen> {
  late Future<List<AddIn>> addIns;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addIns = AddInService.getAddIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddItemScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAddInScreen()),
          ).then((value) {
            setState(() {
              addIns = AddInService.getAddIn(context);
            });
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<AddIn>>(
          future: addIns,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      AddIn addIn = snapshot.data![index];
                      return Row(
                        children: [
                          Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddAddInScreen(
                                          id: addIn.id,
                                          name: addIn.name,
                                          price: addIn.price)),
                                ).then((value) {
                                  setState(() {
                                    addIns = AddInService.getAddIn(context);
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
                                      Text(addIn.name),
                                      Text("Rs. ${addIn.price}"),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, addIn.id)
                                  .then((value) {
                                if (value) {
                                  setState(() {
                                    addIns = AddInService.getAddIn(context);
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
              await AddInService.deleteAddIn(id, context);
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
