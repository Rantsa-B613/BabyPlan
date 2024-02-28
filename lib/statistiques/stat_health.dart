import 'package:flutter/material.dart';

class StateButton extends StatefulWidget {
  const StateButton({Key? key}) : super(key: key);

  @override
  State<StateButton> createState() => _StateButtonState();
}

class _StateButtonState extends State<StateButton> {
  List<String> buttonTexts = ["8 mois", "85 cm", "8 kg", "Bonne santé"];
  List<String> imagePaths = ["assets/images/trois.png", "assets/images/deux.png", "assets/images/un.png", "assets/images/trois.png"];

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
              Container(
                height: 200,
                width: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit
                        .cover,
                  ),
                ),
              ),
              Text(
                buttonTexts[index],
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
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
        height:  110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildButton(imagePath: imagePaths[0], index:  0),
            SizedBox(width:  8.0), // Removed const
            buildButton(imagePath: imagePaths[1], index:  1),
            SizedBox(width:  8.0), // Removed const
            buildButton(imagePath: imagePaths[2], index:  2),
            SizedBox(width:  10.0), // Removed const
            buildButton(imagePath: imagePaths[3], index:  3),
          ],
        ),
      ),
    );
  }
}
