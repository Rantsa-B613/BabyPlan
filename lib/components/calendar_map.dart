import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'notes.dart'; // Importez le fichier des notes
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ~~~~~~~~ Bar de Navogation ~~~~~~~~~//

            Container(
                margin: const EdgeInsets.only(
                  top: 64.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => print("Ajout liste"),
                          child: SvgPicture.asset(
                            "assets/icons/list.svg",
                            height: 34.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => print("Ajout plats"),
                          child: SvgPicture.asset(
                            "assets/icons/add.svg",
                            height: 34.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: Text(
                            "Salama tompoko ",
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              children: [
                                Text(
                                  "Prendre soins de votre ",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 26.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  "ENFANT",
                                  style: GoogleFonts.righteous(
                                    fontSize: 28.0,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  " ensemble !!! ",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 28.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
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
              onEdit: _editNote,
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
  void _editNote(DateTime date, int noteIndex, String newText) {
    setState(() {
      _events[date]![noteIndex] = newText;
    });
  }
}
