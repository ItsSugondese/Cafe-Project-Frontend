import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Popup Example'),
        ),
        body: Center(
          child: MemberButton(),
        ),
      ),
    );
  }
}

class MemberButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: ElevatedButton(
        onPressed: () {
          _showMemberPopup(context);
        },
        child: Text('Member'),
      ),
    );
  }

  Future<void> _showMemberPopup(BuildContext context) async {
    String phoneNumber = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Member Popup'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                onChanged: (value) {
                  phoneNumber = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Perform the search operation and send the response to the backend
                  _sendSearchRequest(phoneNumber);

                  // Close the popup
                  Navigator.of(context).pop();
                },
                child: Text('Search'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendSearchRequest(String phoneNumber) {
    // Implement your logic to send the search request to the backend
    print('Sending search request for contact number: $phoneNumber');
    // You can make API calls or perform other operations here.
  }
}
