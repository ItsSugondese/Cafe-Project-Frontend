import 'package:bislerium_cafe/features/addins/select_add_in_screen.dart';
import 'package:bislerium_cafe/features/coffee/select_coffee_screen.dart';
import 'package:bislerium_cafe/features/member/select_member_screen.dart';
import 'package:bislerium_cafe/features/orders/order-service/order_service.dart';
import 'package:bislerium_cafe/helper/drawer.dart';
import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:bislerium_cafe/model/coffee/coffee.dart';
import 'package:bislerium_cafe/model/member/member.dart';
import 'package:bislerium_cafe/podo/order/order_request.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Member? selectedMember;
  Coffee? selectedCoffee;
  double? realCoffeePrice;
  List<AddIn> selectedAddIns = [];
  final ScrollController _firstController = ScrollController();
  final ScrollController _secondController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _showMemberPopup(context, (member) {
                    setState(() {
                      selectedMember = member;
                      if (selectedCoffee != null) {
                        if (selectedMember!.coffeeCount >= 10) {
                          selectedCoffee!.price = 0;
                        } else if (selectedMember!.isMember) {
                          selectedCoffee!.price = selectedCoffee!.price -
                              ((10 / 100) * selectedCoffee!.price);
                        } else {
                          selectedCoffee!.price = realCoffeePrice!;
                        }
                      }
                    });
                  });
                },
                child: Text('Member'),
              ),
              selectedMember == null
                  ? const SizedBox()
                  : Text(
                      "${selectedMember!.name} (${selectedMember!.phoneNumber}) ")
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _showCoffeePopup(context, (coffee) {
                    setState(() {
                      selectedCoffee = coffee;
                      realCoffeePrice = selectedCoffee!.price;
                      if (selectedMember != null) {
                        if (selectedMember!.coffeeCount >= 10) {
                          selectedCoffee!.price = 0;
                        } else if (selectedMember!.isMember) {
                          selectedCoffee!.price = selectedCoffee!.price -
                              ((10 / 100) * selectedCoffee!.price);
                        } else {
                          selectedCoffee!.price = realCoffeePrice!;
                        }
                      }
                    });
                  });
                },
                child: Text('Coffee'),
              ),
              selectedCoffee == null ? const SizedBox() : chosenCoffee()
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _showAddInPopup(context, (addin) {
                    setState(() {
                      selectedAddIns = addin;
                    });
                  });
                },
                child: Text('AddIns'),
              ),
              selectedAddIns.isEmpty ? const SizedBox() : chosenAddIns()
            ],
          ),
          selectedCoffee != null
              ? Text("Price : ${priceCalculation()}")
              : Container(),
          ElevatedButton(
            onPressed: (selectedCoffee == null || selectedMember == null)
                ? null
                : () {
                    OrderService.addOrder(
                        OrderRequest(
                                memberId: selectedMember!.id,
                                hadDiscount:
                                    selectedMember!.isMember ? true : false,
                                wasRedeem: selectedMember!.coffeeCount >= 10
                                    ? true
                                    : false,
                                price: priceCalculation(),
                                coffeeId: selectedCoffee!.id,
                                hadAddIn:
                                    (selectedAddIns.isEmpty) ? false : true,
                                addInsId:
                                    selectedAddIns.map((e) => e.id).toList())
                            .toJson(),
                        context);
                  },
            child: Text('Order'),
          )
        ],
      ),
    );
  }

  // Future<void> _showMemberPopup(BuildContext context) async {
  void _showMemberPopup(BuildContext context, Function(Member) selectMember) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectMemberScreen(
          memberCallBack: selectMember,
        );
      },
    );
  }

  void _showCoffeePopup(BuildContext context, Function(Coffee) selectCoffee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectCoffeeScreen(
          coffeeCallBack: selectCoffee,
          selectedCoffee: selectedCoffee,
        );
      },
    );
  }

  void _showAddInPopup(
      BuildContext context, Function(List<AddIn>) selectAddIn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectAddInScreen(
          AddInCallBack: selectAddIn,
          addIns: selectedAddIns,
        );
      },
    );
  }

  Widget chosenCoffee() {
    return Container(
      width: 800,
      height: 50,
      child: Scrollbar(
        thumbVisibility: true, // Show the scrollbar always
        controller: _firstController,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _firstController,
          children: (List.from([selectedCoffee!])).map((country) {
            Coffee coffee = country;
            return box(coffee.name, Colors.deepOrangeAccent);
          }).toList(),
        ),
      ),
    );
  }

  Widget chosenAddIns() {
    return Container(
      width: 800,
      height: 50,
      child: Scrollbar(
        thumbVisibility: true, // Show the scrollbar always
        controller: _secondController,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _secondController,
          children: selectedAddIns.map((country) {
            AddIn addIn = country;
            return box(addIn.name, Colors.deepOrangeAccent);
          }).toList(),
        ),
      ),
    );
  }

  Widget box(String title, Color backgroundColor) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 300,
      height: 50, // Specify the height to match your design
      color: backgroundColor,
      alignment: Alignment.center,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  double priceCalculation() {
    return selectedCoffee!.price +
        selectedAddIns.fold(0.0, (sum, addIn) => sum + addIn.price);
  }
}
