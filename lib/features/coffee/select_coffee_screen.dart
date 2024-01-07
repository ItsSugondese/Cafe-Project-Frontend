import 'package:bislerium_cafe/features/coffee/coffee-service/coffee_service.dart';
import 'package:bislerium_cafe/features/coffee/coffee_tile.dart';
import 'package:bislerium_cafe/model/coffee/coffee.dart';
import 'package:flutter/material.dart';

class SelectCoffeeScreen extends StatefulWidget {
  Function(Coffee) coffeeCallBack;
  Coffee? selectedCoffee;
  SelectCoffeeScreen(
      {required this.coffeeCallBack, required this.selectedCoffee});

  @override
  State<SelectCoffeeScreen> createState() => _SelectCoffeeScreenState();
}

class _SelectCoffeeScreenState extends State<SelectCoffeeScreen> {
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? memberExists;
  Coffee? selectedCoffee;
  late Function(Coffee) callback = widget.coffeeCallBack;
  late Future<List<Coffee>> coffeList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coffeList = CoffeeService.getCoffee(context);
    selectedCoffee = widget.selectedCoffee;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select a Coffee'),
      content: Column(
        children: [
          FutureBuilder<List<Coffee>>(
            future: coffeList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No coffee available.');
              } else {
                List<Coffee> coffees = snapshot.data!;
                return _buildCoffeeGrid(coffees);
              }
            },
          ),
          ElevatedButton(
              onPressed: selectedCoffee == null
                  ? null
                  : () {
                      callback(selectedCoffee!);
                      Navigator.pop(context);
                    },
              child: Text("Order"))
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

  Widget _buildCoffeeGrid(List<Coffee> coffees) {
    int? lastIndex;
    return Container(
      height: 200,
      width: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: coffees.length,
        itemBuilder: (context, index) {
          return CoffeeTile(
            coffee: coffees[index],
            isSelected: selectedCoffee == null
                ? false
                : selectedCoffee!.id == coffees[index].id,
            callback: () {
              setState(() {
                selectedCoffee = coffees[index];
              });
            },
          );
        },
      ),
    );
  }
}
