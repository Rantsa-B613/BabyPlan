import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'notes.dart'; // Importez le fichier des notes

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {};

  late TextEditingController _eventController;

  @override
  void initState() {
    super.initState();
    _eventController = TextEditingController();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendrier'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ~~~~~~~~ Calendrier ~~~~~~~~~//
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: Colors.blue),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),

            // ~~~~~~~~ NOTES ~~~~~~~~~//
            NotesList(
              events: _events,
              onDelete: _deleteNote,
              onEdit: _editNote, // Nouveau callback pour l'édition des notes
            ), // Utilisez le widget NotesList
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ajouter une note'),
                content: TextFormField(
                  controller: _eventController,
                  decoration: InputDecoration(
                    labelText: 'Entrez votre note',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ajouter'),
                    onPressed: () {
                      setState(() {
                        _events[_selectedDay] = _events[_selectedDay] ?? [];
                        _events[_selectedDay]!.add(_eventController.text);
                        _eventController.clear();
                      });
                      Navigator.of(context).pop(); // Ferme le dialog après avoir ajouté la note
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Fonction pour supprimer une note
  void _deleteNote(DateTime date, int noteIndex) {
    setState(() {
      _events[date]!.removeAt(noteIndex);
      if (_events[date]!.isEmpty) {
        _events.remove(date);
      }
    });
  }

  // Fonction pour modifier une note
  void _editNote(DateTime date, int noteIndex, String newText) {
    setState(() {
      _events[date]![noteIndex] = newText;
    });
  }
}
