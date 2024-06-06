import 'package:first_project/node_data.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(this.nodeData, this.addUser,  this.removeUser, {super.key});
  final NodeData nodeData;
  final void Function(NodeData srcUser) addUser;
  final void Function(NodeData deleteUser) removeUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 5.0, color: Colors.grey, offset: Offset(0, -3)),
          BoxShadow(blurRadius: 0.0, color: Colors.black, offset: Offset(0, 3))
        ],
      ),
      child: nodeData.id != -1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(nodeData.image!, height: 50),
                    Text('Name: ${nodeData.name!}')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => addUser(nodeData),
                      child: Text('Add user'),
                    ),
                    ElevatedButton(onPressed: () => removeUser(nodeData), child: Text('Delete user'))
                  ],
                )
              ],
            )
          : Center(child: Text('No data')),
    );
  }
}
