import 'package:bislerium_cafe/features/member/member-service/member_service.dart';
import 'package:bislerium_cafe/model/member/member.dart';
import 'package:bislerium_cafe/podo/member/member_request.dart';
import 'package:flutter/material.dart';

class SelectMemberScreen extends StatefulWidget {
  Function(Member) memberCallBack;
  SelectMemberScreen({required this.memberCallBack});

  @override
  State<SelectMemberScreen> createState() => _SelectMemberScreenState();
}

class _SelectMemberScreenState extends State<SelectMemberScreen> {
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? memberExists;
  late Future<Member?> searchedMember;
  late Member selectedMember;
  late Function(Member) callback = widget.memberCallBack;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Member Popup'),
      content: Column(
        children: [
          TextField(
            controller: contactController,
            decoration: InputDecoration(labelText: 'Contact Number'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Perform the search operation and send the response to the backend

              Member? member = await MemberService.getSingleMemberByContact(
                  context, contactController.text);

              setState(() {
                searchedMember = Future.value(member);
                memberExists = member != null;
              });

              // Close the popup
            },
            child: Text('Search'),
          ),
          memberExists == null
              ? const SizedBox()
              : memberExists == false
                  ? ifMemberFalse()
                  : ifMemberTrue()
        ],
      ),
    );
  }

  Column ifMemberFalse() {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            // Perform the search operation and send the response to the backend
            selectedMember = await MemberService.saveMember(
                context,
                MemberRequest(
                        name: nameController.text,
                        phoneNumber: contactController.text)
                    .toJson());

            callback(selectedMember);
            Navigator.of(context).pop();
            // Close the popup
            // Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  FutureBuilder<Member?> ifMemberTrue() {
    return FutureBuilder<Member?>(
      future: searchedMember,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Member member = snapshot.data!;

          return Center(
            child: Card(
              child: GestureDetector(
                onTap: () {
                  callback(member);
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Column(
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
                          Text(member.name),
                          Text("Rs. ${member.phoneNumber}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [Text("${snapshot.error}")],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
