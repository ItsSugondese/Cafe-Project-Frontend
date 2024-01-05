import 'package:bislerium_cafe/features/coffee/coffee-service/coffee_service.dart';
import 'package:bislerium_cafe/podo/coffee/coffee_request.dart';
import 'package:flutter/material.dart';

class AddCoffeeScreen extends StatelessWidget {
  int? id;
  double? price;
  String? name;

  // Use the constructor to receive the data
  AddCoffeeScreen({Key? key, this.id, this.name, this.price}) : super(key: key);
  final TextEditingController _coffeeIdController = TextEditingController();
  final TextEditingController _coffeeNameController = TextEditingController();
  final TextEditingController _coffeePriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      _coffeeIdController.text = id.toString();
    }
    if (price != null) {
      _coffeePriceController.text = price.toString();
    }
    if (name != null) {
      _coffeeNameController.text = name.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _coffeeNameController,
              decoration: InputDecoration(labelText: 'Coffee Name?'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _coffeePriceController,
              decoration: InputDecoration(labelText: 'Coffee Price?'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Return the added item to the previous screen
                CoffeeRequest request = CoffeeRequest(
                    id: _coffeeIdController.text.isNotEmpty == true
                        ? int.parse(_coffeeIdController.text)
                        : null,
                    name: _coffeeNameController.text,
                    price: double.parse(_coffeePriceController.text));

                try {
                  await CoffeeService.addCoffee(request.toJson(), context);
                  Navigator.pop(context);
                } on Exception {
                  print("done");
                }
              },
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
