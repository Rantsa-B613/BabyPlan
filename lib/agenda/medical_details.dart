import 'package:flutter/material.dart';
import '../components/details_health.dart';
import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/new_habit_box.dart';

class Details_medical extends StatefulWidget {
  const Details_medical({Key? key}) : super(key: key);

  @override
  State<Details_medical> createState() => _Details_medicalState();
}

class _Details_medicalState extends State<Details_medical> {
  List todaysHabitList = [
    [
      "Assurez-vous de programmer des visites régulières chez le pédiatre pour surveiller la croissance et le développement de votre bébé. Les rendez-vous de suivi sont essentiels pour détecter tout problème de santé éventuel et pour poser des questions sur les soins et l'éducation de votre enfant.",
      false
    ],
    ["Votre enfant devrait avoir reçu ses vaccins de routine jusqu'à présent. Assurez-vous qu'il a bien reçu les vaccins recommandés par son médecin, y compris ceux pour la diphtérie, le tétanos, la coqueluche, l'Haemophilus influenzae de type b (Hib) et d'autres maladies infantiles.", true],
    ["Le sommeil de votre bébé peut être variable à cet âge, mais il devrait généralement dormir environ 12 à 14 heures par jour, y compris les siestes. Établissez une routine de sommeil régulière pour favoriser un repos optimal.", false],
  ];

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

  final _newHabitNameController = TextEditingController();

  void createNexHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabitBox(
          controller: _newHabitNameController,
          hintText: 'Mampidira zavatra atao ...',
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
  }

  void cancelNewHabit() {
    Navigator.of(context).pop();
    _newHabitNameController.clear();
  }

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewHabitBox(
            controller: _newHabitNameController,
            hintText: todaysHabitList[index][0],
            onSave: () => saveExistingHabit(index),
            onCancel: cancelNewHabit,
          );
        });
  }

  void saveExistingHabit(int index) {
    setState(() {
      todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
  }

  void deletedHabit(int index) {
    setState(() {
      todaysHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNexHabit,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const HealthScreen(),
            const SizedBox(
              height: 25.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 23.0),
              child: Row(
                children: [
                  Text(
                    "Carnet",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                   SizedBox(
                    width: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Notes récentes",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todaysHabitList.length,
              padding: const EdgeInsets.only(bottom: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return HabitTile(
                  habitName: todaysHabitList[index][0],
                  habitCompleted: todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deletedHabit(index),
                );
              },
            ),

            const SizedBox(
              height: 70.0,
            ),
          ],
        ),
      ),
    );
  }
}
