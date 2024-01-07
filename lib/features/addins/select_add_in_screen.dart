import 'package:bislerium_cafe/features/addins/add-in-service/add_in_service.dart';
import 'package:bislerium_cafe/features/addins/add_in_tile.dart';
import 'package:bislerium_cafe/features/coffee/coffee-service/coffee_service.dart';
import 'package:bislerium_cafe/features/coffee/coffee_tile.dart';
import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:bislerium_cafe/model/coffee/coffee.dart';
import 'package:flutter/material.dart';

class SelectAddInScreen extends StatefulWidget {
  Function(List<AddIn>) AddInCallBack;
  List<AddIn> addIns;
  SelectAddInScreen(
      {super.key, required this.AddInCallBack, required this.addIns});

  @override
  State<SelectAddInScreen> createState() => _SelectAddInScreenState();
}

class _SelectAddInScreenState extends State<SelectAddInScreen> {
  late List<AddIn> selectedAddIn;
  late Function(List<AddIn>) callback = widget.AddInCallBack;
  late Future<List<AddIn>> addInList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addInList = AddInService.getAddIn(context);
    selectedAddIn = widget.addIns;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select a Contact'),
      content: Column(
        children: [
          FutureBuilder<List<AddIn>>(
            future: addInList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No contacts available.');
              } else {
                List<AddIn> addIns = snapshot.data!;
                return _buildAddInGrid(addIns);
              }
            },
          ),
          ElevatedButton(
              onPressed: () {
                callback(selectedAddIn);
                Navigator.pop(context);
              },
              child: Text(selectedAddIn.isEmpty ? "Cancel" : "Order"))
        ],
      ),
    );
    // return AlertDialog(
    //   title: Text('Member Popup'),
    //   content: Column(
    //     children: [
    //       TextField(
    //         controller: contactController,
    //         decoration: InputDecoration(labelText: 'Contact Number'),
    //       ),
    //       SizedBox(height: 20),
    //       ElevatedButton(
    //         onPressed: () async {
    //           // Perform the search operation and send the response to the backend

    //           Member? member = await MemberService.getSingleMemberByContact(
    //               context, contactController.text);

    //           setState(() {
    //             searchedMember = Future.value(member);
    //             memberExists = member != null;
    //           });

    //           // Close the popup
    //         },
    //         child: Text('Search'),
    //       ),
    //       memberExists == null
    //           ? const SizedBox()
    //           : memberExists == false
    //               ? ifMemberFalse()
    //               : ifMemberTrue()
    //     ],
    //   ),
    // );
  }

  Widget _buildAddInGrid(List<AddIn> addIns) {
    return Container(
      height: 200,
      width: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: addIns.length,
        itemBuilder: (context, index) {
          return AddInTile(
              addIn: addIns[index],
              isSelected: checkIfAddInInList(addIns[index], selectedAddIn),
              sendAddin: (val) {
                setState(() {
                  if (val) {
                    if (!checkIfAddInInList(addIns[index], selectedAddIn)) {
                      selectedAddIn.add(addIns[index]);
                    }
                  } else {
                    selectedAddIn
                        .remove(returnSameAddIn(addIns[index], selectedAddIn));
                  }
                });
              });
        },
      ),
    );
  }

  bool checkIfAddInInList(AddIn addIn, List<AddIn> addInsList) {
    AddIn? matchingAddIn;
    try {
      matchingAddIn = addInsList.firstWhere((e) => addIn.id == e.id);
    } catch (e) {
      matchingAddIn = null;
    }
    return matchingAddIn != null ? true : false;
  }

  AddIn returnSameAddIn(AddIn addIn, List<AddIn> addInsList) {
    AddIn matchingAddIn;
    matchingAddIn = addInsList.firstWhere((e) => addIn.id == e.id);
    return matchingAddIn;
  }
}
