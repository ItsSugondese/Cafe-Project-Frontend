import 'package:bislerium_cafe/model/addin/add_in.dart';
import 'package:bislerium_cafe/model/coffee/coffee.dart';
import 'package:flutter/material.dart';

class AddInTile extends StatefulWidget {
  final AddIn addIn;
  Function(bool) sendAddin;
  bool isSelected;

  AddInTile(
      {Key? key,
      required this.addIn,
      required this.isSelected,
      required this.sendAddin})
      : super(key: key);

  @override
  _AddInTileState createState() => _AddInTileState();
}

class _AddInTileState extends State<AddInTile> {
  late bool isSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.sendAddin(isSelected);
        });
      },
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
              widget.addIn.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
