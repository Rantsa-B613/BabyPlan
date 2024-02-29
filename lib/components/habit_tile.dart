import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.deleteTapped,
    required this.settingsTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 25.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: settingsTapped,
                backgroundColor: Colors.black,
                icon: Icons.settings,
                borderRadius: BorderRadius.circular(12),
              ),
              SlidableAction(
                onPressed: deleteTapped,
                backgroundColor: Colors.red,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ]
            ),
            child: Row(
              children: [
                const SizedBox(width: 17.0,),
                 Container(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: Text(
                    habitName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
