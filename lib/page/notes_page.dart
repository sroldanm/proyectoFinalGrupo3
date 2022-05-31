import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note/db/notes_database.dart';
import 'package:note/model/note.dart';
import 'package:note/page/edit_note_page.dart';
import 'package:note/page/note_detail_page.dart';
import 'package:note/widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> _notes;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => _isLoading = true);
    _notes = await NotesDatabase.instance.readAllNotes();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notas',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [
            Icon(Icons.search),
            SizedBox(
              width: 12,
            ),
          ],
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : _notes.isEmpty
                  ? const Text(
                      'Not exists notes',
                      style: TextStyle(color: Colors.black26, fontSize: 24),
                    )
                  //widget personalizado
                  : builNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black26,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );
            refreshNotes();
          },
        ),
      );

  //widget personalizado
  Widget builNotes() => StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8),
      itemCount: _notes.length,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (contex, index) {
        final note = _notes[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPage(noteId: note.id!),
            ));
            refreshNotes();
          },
          child: NoteCardWidget(note: note, index: index),
        );
      });
}
