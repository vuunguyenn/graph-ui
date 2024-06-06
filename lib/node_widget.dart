import 'package:first_project/node_data.dart';
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  const NodeWidget({super.key, required this.idSelected, required this.data});
  final int idSelected;
  final NodeData data;

  @override
  Widget build(BuildContext context) {
    bool isSelected = idSelected == data.id;

    print('node ${data.id} ${isSelected}');
    return AnimatedContainer(
        width: isSelected ? 60 : 50,
        height: isSelected ? 60 : 50,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.transparent.withOpacity(1),
          shape: BoxShape.circle,
          border: Border.all(
              color: isSelected ? Colors.red : Colors.blue,
              width: isSelected ? 5.0 : 2.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: ClipOval(
            child: Image.asset(
              data.image!,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
