import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:notes_app/screens/add_new_note.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('NOTES APP'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: (notesProvider.notes.length > 0)
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: notesProvider.notes.length,
                itemBuilder: (context, index) {
                  Note currentNote = notesProvider.notes[index];

                  return GestureDetector(
                    onTap: () {
                      // Update
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddNewNote(
                                  isUpdate: true,
                                  note: currentNote,
                                )),
                      );
                    },
                    onLongPress: () {
                      // Delete
                      notesProvider.deleteNote(currentNote);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(currentNote.title!),
                          // SizedBox(
                          //   height: 7,
                          // ),
                          // Text(currentNote.content!),

                          Text(
                            currentNote.title!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            currentNote.content!,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text("No notes yet"),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddNewNote(
                isUpdate: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
