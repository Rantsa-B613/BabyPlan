import 'package:flutter/material.dart';
import 'package:kellan/components/details_health.dart';
import 'package:table_calendar/table_calendar.dart';
import 'notes.dart';
import '../routes/navigation_bar.dart';

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
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppNavigationBar(),

            const SizedBox(
              height: 5.0,
            ),
            // ~~~~~~~~ Calendrier ~~~~~~~~~//
            SingleChildScrollView(
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: TableCalendar(
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
                        todayDecoration: BoxDecoration(
                          color: Colors.pink[100],
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(color: Colors.white),
                        selectedDecoration: BoxDecoration(
                          color: Colors.pink[100],
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ~~~~~~~~ NOTES ~~~~~~~~~//
            SingleChildScrollView(
              child: Flexible(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 150),
                  margin:
                      const EdgeInsets.only(right: 0.0, left: 0.0, top: 25.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    ),
                  ),
                  child: NotesList(
                    events: _events,
                    onDelete: _deleteNote,
                    onEdit: _editNote,
                  ),
                ),
              ),
            ),
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
                      Navigator.of(context)
                          .pop(); // Ferme le dialog après avoir ajouté la note
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
  void _editNote(DateTime date, int noteIndex, String newText, Color color) {
    setState(() {
      _events[date]![noteIndex] = newText;
    });
  }
}
