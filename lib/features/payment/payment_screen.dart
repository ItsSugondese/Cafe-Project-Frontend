import 'package:bislerium_cafe/features/orders/order-service/order_service.dart';
import 'package:bislerium_cafe/features/transaction/transaction-service/transaction_service.dart';
import 'package:bislerium_cafe/model/orders/order.dart';
import 'package:bislerium_cafe/podo/transaction/transaction_request.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Future<List<Order>> ordersList;
  final _firstController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordersList = OrderService.getOrder(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee'),
      ),
      body: Scrollbar(
        child: FutureBuilder<List<Order>>(
            future: ordersList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _firstController,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        Order order = snapshot.data![index];
                        return Row(
                          children: [
                            Card(
                              child: SizedBox(
                                width: 300,
                                height: 100,
                                child: Column(children: [
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
                                      Text(order.coffeeName),
                                      Text("Rs. ${order.price}"),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            Text(order.memberName),
                            const SizedBox(
                              width: 20,
                            ),
                            Text("${order.price}"),
                            const SizedBox(
                              width: 20,
                            ),
                            order.addInName.isEmpty
                                ? Container()
                                : Container(
                                    width: 200,
                                    height: 200,
                                    child: Scrollbar(
                                      thumbVisibility:
                                          true, // Show the scrollbar always
                                      controller: _firstController,
                                      child: ListView.builder(
                                        itemCount: order.addInName.length,
                                        itemBuilder: (context, index) =>
                                            Text(order.addInName[index]),
                                      ),
                                    )),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              child: Text("Pay"),
                              onPressed: () async {
                                // _showDeleteConfirmationDialog(context, order.id)
                                //     .then((value) {
                                //   if (value) {
                                //     setState(() {
                                //       ordersList = CoffeeService.getCoffee(context);
                                //     });
                                //   }
                                // });
                                bool savedStatus =
                                    await TransactionService.addTransaction(
                                        TransactionRequest(
                                                orderId: order.id,
                                                memberId: order.memberId)
                                            .toJson(),
                                        context);

                                if (savedStatus) {
                                  setState(() {
                                    snapshot.data!.removeAt(index);
                                  });
                                }
                              },
                            )
                          ],
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [Text("${snapshot.error}")],
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
