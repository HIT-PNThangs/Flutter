import 'package:flutter/material.dart';

import 'google_sheets_api.dart';
import 'textbox.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: GoogleSheetsApi.currentNotes.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return MyTextBox(text: GoogleSheetsApi.currentNotes[index][0]);
        });
  }
}
