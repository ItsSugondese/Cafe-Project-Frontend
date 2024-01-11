import 'dart:io';

import 'package:bislerium_cafe/features/addins/add-in-service/add_in_service.dart';
import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:bislerium_cafe/podo/add-in/add_in_request.dart';
import 'package:bislerium_cafe/services/temporary-attachments/temporary_attachments_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddAddInScreen extends StatefulWidget {
  AddIn? addIn;
  // Use the constructor to receive the data
  AddAddInScreen({Key? key, this.addIn}) : super(key: key);

  @override
  State<AddAddInScreen> createState() => _AddAddInScreenState();
}

class _AddAddInScreenState extends State<AddAddInScreen> {
  final TextEditingController _addInIdController = TextEditingController();

  final TextEditingController _addInNameController = TextEditingController();

  final TextEditingController _addInPriceController = TextEditingController();

  final FocusNode _addInPriceFocusNode = FocusNode();
  final FocusNode _addInNameFocusNode = FocusNode();

  File? _imageFile;
  String? fileName;
  String? addInName;
  double? addInPrice;
  int? fileId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addInPriceFocusNode.addListener(_onFocusPriceChange);
    _addInPriceFocusNode.addListener(_onFocusNameChange);
  }

  void _onFocusPriceChange() {
    if (!_addInPriceFocusNode.hasFocus) {
      // Text field lost focus, perform setState or any other action
      if (_addInPriceController.text.isNotEmpty) {
        setState(() {
          addInPrice = double.parse(_addInPriceController.text);
        });
      }
    }
  }

  void _onFocusNameChange() {
    if (!_addInNameFocusNode.hasFocus) {
      // Text field lost focus, perform setState or any other action
      if (_addInNameController.text.isNotEmpty) {
        setState(() {
          addInName = _addInNameController.text;
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
    if (widget.addIn != null) {
      _addInIdController.text = widget.addIn!.id.toString();
      _addInPriceController.text = widget.addIn!.price.toString();

      _addInNameController.text = widget.addIn!.name.toString();
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
              focusNode: _addInNameFocusNode,
              decoration: InputDecoration(labelText: 'AddIn Name?'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _addInPriceController,
              focusNode: _addInPriceFocusNode,
              decoration: InputDecoration(labelText: 'AddIn Price?'),
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
              onPressed: addInName == null ||
                      fileName == null ||
                      addInPrice == null
                  ? null
                  : () async {
                      // Return the added item to the previous screen
                      AddInRequest request = AddInRequest(
                          id: _addInIdController.text.isNotEmpty == true
                              ? int.parse(_addInIdController.text)
                              : null,
                          name: _addInNameController.text,
                          price: double.parse(_addInPriceController.text),
                          fileId: fileId);

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
