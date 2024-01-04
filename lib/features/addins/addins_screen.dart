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
  List<AddIn> addIns = [];
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
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<AddIn>>(
          future: getAddIn(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      AddIn addIn = snapshot.data![index];
                      return Column(
                        children: [
                          Card(
                            child: SizedBox(
                              width: 300,
                              height: 100,
                              child: Row(
                                children: [
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
                                  )
                                ],
                              ),
                            ),
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
