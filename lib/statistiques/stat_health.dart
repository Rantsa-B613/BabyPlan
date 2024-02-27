import 'package:flutter/material.dart';

class StateButton extends StatefulWidget {
  const StateButton({Key? key}) : super(key: key);

  @override
  State<StateButton> createState() => _StateButtonState();
}

class _StateButtonState extends State<StateButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepPurple[100],
        ),
        child: const Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 15),
            Text("25 Kg"),
          ],
        ),
      ),
    );
  }
}
