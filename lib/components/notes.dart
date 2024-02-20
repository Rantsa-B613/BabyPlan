import 'package:flutter/material.dart';

class NotesList extends StatefulWidget {
  final Map<DateTime, List<String>> events;
  final Function(DateTime, int, String) onEdit; // Nouveau callback pour l'édition des notes
  final Function(DateTime, int) onDelete;

  const NotesList({Key? key, required this.events, required this.onDelete, required this.onEdit}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Les dates importantes :',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              final eventDate = widget.events.keys.elementAt(index);
              final eventList = widget.events[eventDate];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${eventDate.day}/${eventDate.month}/${eventDate.year}:',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: eventList?.length ?? 0,
                    itemBuilder: (context, noteIndex) {
                      return ListTile(
                        title: Text(eventList![noteIndex], style: TextStyle(color: Colors.white),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white,),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Modifier la note'),
                                      content: TextFormField(
                                        initialValue: eventList[noteIndex],
                                        onChanged: (newValue) {
                                          eventList[noteIndex] = newValue;
                                        },
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Enregistrer'),
                                          onPressed: () {
                                            widget.onEdit(eventDate, noteIndex, eventList[noteIndex]);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.white,),
                              onPressed: () {
                                setState(() {
                                  widget.onDelete(eventDate, noteIndex);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
