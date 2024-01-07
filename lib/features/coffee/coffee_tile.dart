import 'package:bislerium_cafe/model/coffee/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  bool isSelected;
  VoidCallback callback;

  CoffeeTile(
      {Key? key,
      required this.coffee,
      required this.isSelected,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   setState(() {
      //     isSelected = !isSelected;
      //   });
      // },
      onTap: callback,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(widget.coffee.imageUrl),
              //   fit: BoxFit.cover,
              // ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: isSelected
                ? Container(
                    color: Colors.black.withOpacity(0.3),
                  )
                : Container(),
          ),
          isSelected
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24.0,
                )
              : Container(),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: Text(
              coffee.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
