import 'dart:math';

import 'package:bislerium_cafe/features/addins/add-in-service/add_in_service.dart';
import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:bislerium_cafe/podo/add-in/add_in_request.dart';
import 'package:flutter/material.dart';

class AddAddInScreen extends StatelessWidget {
  int? id;
  double? price;
  String? name;

  // Use the constructor to receive the data
  AddAddInScreen({Key? key, this.id, this.name, this.price}) : super(key: key);
  final TextEditingController _addInIdController = TextEditingController();
  final TextEditingController _addInNameController = TextEditingController();
  final TextEditingController _addInPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      _addInIdController.text = id.toString();
    }
    if (price != null) {
      _addInPriceController.text = price.toString();
    }
    if (name != null) {
      _addInNameController.text = name.toString();
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
              controller: _addInNameController,
              decoration: InputDecoration(labelText: 'AddIn Name?'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _addInPriceController,
              decoration: InputDecoration(labelText: 'AddIn Price?'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Return the added item to the previous screen
                AddInRequest request = AddInRequest(
                    id: _addInIdController.text.isNotEmpty == true
                        ? int.parse(_addInIdController.text)
                        : null,
                    name: _addInNameController.text,
                    price: double.parse(_addInPriceController.text));

                try {
                  await AddInService.addAddIn(request.toJson(), context);
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
