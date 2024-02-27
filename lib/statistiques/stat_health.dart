import 'package:flutter/material.dart';

class StateButton extends StatefulWidget {
  const StateButton({Key? key}) : super(key: key);

  @override
  State<StateButton> createState() => _StateButtonState();
}

class _StateButtonState extends State<StateButton> {
  List<String> buttonTexts = ["35 Kg", "25 Cm", "25 Cm", "25 Cm"];
  List<String> imagePaths = ["assets/logo.png", "assets/logo.png", "assets/logo.png", "assets/logo.png"];

  Widget buildButton({required String imagePath, required int index}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _showDialog(index);
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurple[100],
          ),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 150, // Adjust as per your requirement
                height: 150, // Adjust as per your requirement
              ),
              SizedBox(width: 1),
              Text(
                buttonTexts[index],
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Changer le texte"),
          content: TextField(
            onChanged: (value) {
              setState(() {
                buttonTexts[index] = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Entrez votre note',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:  5.0),
      child: Container(
        height:  100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildButton(imagePath: imagePaths[0], index:  0),
            const SizedBox(width:  8.0),
            buildButton(imagePath: imagePaths[1], index:  1),
            const SizedBox(width:  8.0),
            buildButton(imagePath: imagePaths[2], index:  2),
            const SizedBox(width:  10.0),
            buildButton(imagePath: imagePaths[3], index:  3),
          ],
        ),
      ),
    );
  }
}
