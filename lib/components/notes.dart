import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NotesList extends StatefulWidget {
  final Map<DateTime, List<String>> events;
  final Function(DateTime, int, String, Color) onEdit;
  final Function(DateTime, int) onDelete;

  const NotesList({Key? key, required this.events, required this.onDelete, required this.onEdit}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  Map<DateTime, Color> _selectedColors = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            'Notes importantes : ',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 2.0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.events.length,
          itemBuilder: (context, index) {
            final eventDate = widget.events.keys.elementAt(index);
            final eventList = widget.events[eventDate];
            final currentColor = _selectedColors[eventDate] ?? Colors.pink[100];

            return Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              margin: const EdgeInsets.only(right: 2.0, left: 5.0, top: 25.0),
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
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
                    padding: const EdgeInsets.only(top: 2.0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: eventList?.length ?? 0,
                    itemBuilder: (context, noteIndex) {
                      return ListTile(
                        title: Text(eventList![noteIndex], style: const TextStyle(color: Colors.white),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 25.0,),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white,),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Modifier la note'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            initialValue: eventList[noteIndex],
                                            onChanged: (newValue) {
                                              eventList[noteIndex] = newValue;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Choisir la couleur'),
                                                    content: SingleChildScrollView(
                                                      child: ColorPicker(
                                                        pickerColor: _selectedColors[eventDate] ?? Colors.red,
                                                        onColorChanged: (color) {
                                                          setState(() {
                                                            _selectedColors[eventDate] = color;
                                                          });
                                                        },
                                                        colorPickerWidth: 300.0,
                                                        pickerAreaHeightPercent: 0.7,
                                                        enableAlpha: true,
                                                        displayThumbColor: true,
                                                        showLabel: true,
                                                        paletteType: PaletteType.hsv,
                                                        pickerAreaBorderRadius: const BorderRadius.only(
                                                          topLeft: const Radius.circular(2.0),
                                                          topRight: const Radius.circular(2.0),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('Ok'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                          widget.onEdit(eventDate, noteIndex, eventList[noteIndex], _selectedColors[eventDate] ?? Colors.red);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text('Choisir la couleur'),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Annuler'),
                                          onPressed: () {
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
                              icon: const Icon(Icons.delete, color: Colors.white,),
                              onPressed: () {
                                setState(() {
                                  widget.onDelete(eventDate, noteIndex);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.palette, color: Colors.white,),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Choisir la couleur'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: _selectedColors[eventDate] ?? Colors.red,
                                          onColorChanged: (color) {
                                            setState(() {
                                              _selectedColors[eventDate] = color;
                                            });
                                          },
                                          colorPickerWidth: 300.0,
                                          pickerAreaHeightPercent: 0.7,
                                          enableAlpha: true,
                                          displayThumbColor: true,
                                          showLabel: true,
                                          paletteType: PaletteType.hsv,
                                          pickerAreaBorderRadius: const BorderRadius.only(
                                            topLeft: const Radius.circular(2.0),
                                            topRight: const Radius.circular(2.0),
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            widget.onEdit(eventDate, noteIndex, eventList[noteIndex], _selectedColors[eventDate] ?? Colors.red);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
