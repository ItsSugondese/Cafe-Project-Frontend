import 'package:bislerium_cafe/features/member/member-service/member_service.dart';
import 'package:bislerium_cafe/features/transaction/transaction-service/transaction_service.dart';
import 'package:bislerium_cafe/helper/drawer.dart';
import 'package:bislerium_cafe/model/member/member.dart';
import 'package:bislerium_cafe/model/transaction/transaction.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late Future<List<Transaction>> transactionFuture;

  @override
  void initState() {
    super.initState();
    transactionFuture = TransactionService.getTransaction(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Table Example'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: transactionFuture,
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
              List<Transaction> transactions = snapshot.data ?? [];

              return Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        TransactionService.downloadPdf();
                      },
                      child: Text("Generate Report")),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Member')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('Coffee')),
                          DataColumn(label: Text('Add-Ins')),
                        ],
                        rows: transactions.map((transaction) {
                          return DataRow(cells: [
                            DataCell(Text(transaction.memberName)),
                            DataCell(Text(transaction.date)),
                            DataCell(Text("${transaction.price}")),
                            DataCell(Text("${transaction.coffeeName}")),
                            DataCell(Text("${transaction.addInName}")),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
