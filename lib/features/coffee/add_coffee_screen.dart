import 'dart:io';

import 'package:bislerium_cafe/features/coffee/coffee-service/coffee_service.dart';
import 'package:bislerium_cafe/podo/coffee/coffee_request.dart';
import 'package:bislerium_cafe/services/temporary-attachments/temporary_attachments_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddCoffeeScreen extends StatefulWidget {
  int? id;
  double? price;
  String? name;

  // Use the constructor to receive the data
  AddCoffeeScreen({Key? key, this.id, this.name, this.price}) : super(key: key);

  @override
  State<AddCoffeeScreen> createState() => _AddCoffeeScreenState();
}

class _AddCoffeeScreenState extends State<AddCoffeeScreen> {
  final TextEditingController _coffeeIdController = TextEditingController();

  final TextEditingController _coffeeNameController = TextEditingController();

  final TextEditingController _coffeePriceController = TextEditingController();
  final FocusNode _coffeePriceFocusNode = FocusNode();
  final FocusNode _coffeeNameFocusNode = FocusNode();

  File? _imageFile;
  String? fileName;
  String? coffeeName;
  double? coffePrice;
  int? fileId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeePriceFocusNode.addListener(_onFocusPriceChange);
    _coffeePriceFocusNode.addListener(_onFocusNameChange);
  }

  void _onFocusPriceChange() {
    if (!_coffeePriceFocusNode.hasFocus) {
      // Text field lost focus, perform setState or any other action
      if (_coffeePriceController.text.isNotEmpty) {
        setState(() {
          coffePrice = double.parse(_coffeePriceController.text);
        });
      }
    }
  }

  void _onFocusNameChange() {
    if (!_coffeeNameFocusNode.hasFocus) {
      // Text field lost focus, perform setState or any other action
      if (_coffeeNameController.text.isNotEmpty) {
        setState(() {
          coffeeName = _coffeeNameController.text;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      fileId =
          await TemporaryAttachmentsService.uploadFile(_imageFile!, context);
      setState(() {
        fileName = path.basename(_imageFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      _coffeeIdController.text = widget.id.toString();
    }
    if (widget.price != null) {
      _coffeePriceController.text = widget.price.toString();
    }
    if (widget.name != null) {
      _coffeeNameController.text = widget.name.toString();
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
              focusNode: _coffeeNameFocusNode,
              decoration: InputDecoration(labelText: 'Coffee Name?'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _coffeePriceController,
              focusNode: _coffeePriceFocusNode,
              decoration: InputDecoration(labelText: 'Coffee Price?'),
            ),
            SizedBox(height: 16),

            // Button to pick an image
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _pickImage();
                  },
                  child: Text('Pick Image'),
                ),
                fileName == null ? Container() : Text("${fileName}")
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  coffeeName == null || fileName == null || coffePrice == null
                      ? null
                      : () async {
                          // Return the added item to the previous screen
                          CoffeeRequest request = CoffeeRequest(
                              id: _coffeeIdController.text.isNotEmpty == true
                                  ? int.parse(_coffeeIdController.text)
                                  : null,
                              name: _coffeeNameController.text,
                              price: double.parse(_coffeePriceController.text),
                              fileId: fileId);

                          try {
                            await CoffeeService.addCoffee(
                                request.toJson(), context);
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
