import 'package:bislerium_cafe/features/member/member-service/member_service.dart';
import 'package:bislerium_cafe/helper/drawer.dart';
import 'package:bislerium_cafe/model/member/member.dart';
import 'package:flutter/material.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  late Future<List<Member>> membersFuture;

  @override
  void initState() {
    super.initState();
    membersFuture = MemberService.getMember(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Member'),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder<List<Member>>(
          future: membersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data'),
              );
            } else {
              List<Member> members = snapshot.data ?? [];

              return Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Contact')),
                      DataColumn(label: Text('IsMember')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: members.map((member) {
                      return DataRow(cells: [
                        DataCell(Text(member.name)),
                        DataCell(Text(member.phoneNumber)),
                        DataCell(
                            Icon(member.isMember ? Icons.check : Icons.close)),
                        DataCell(ElevatedButton(
                          child: Text(member.isMember
                              ? "Disable Membership"
                              : "Enable Membership"),
                          onPressed: () async {
                            bool isMember =
                                await MemberService.toggleMembership(
                                    context, member.id);
                            setState(() {
                              member.isMember = isMember;
                            });
                          },
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
