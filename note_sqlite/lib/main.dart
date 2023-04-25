import 'package:flutter/material.dart';

import 'sqlite_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> notes = [];

  bool isLoading = true;

  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();

  void _refreshNote() async {
    final data = await SQLHelper.getAllNote();

    setState(() {
      notes = data;
      isLoading = false;
    });
  }

  Future<void> addNote() async {
    await SQLHelper.createItem(titleTextController.text, descriptionTextController.text);
    _refreshNote();

    return;
  }

  Future<void> updateNote() async {
    // await SQLHelper.createItem(titleTextController.text, descriptionTextController.text);
    // _refreshNote();
    //
    // return;
  }

  void _showForm(int? id) async {
    if (id != null) {
      final note = notes.firstWhere((element) => element['id'] == id);
      titleTextController.text = note['title'];
      descriptionTextController.text = note['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: MediaQuery.of(context).viewInsets.bottom + 120),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: titleTextController,
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionTextController,
                  decoration: const InputDecoration(hintText: "Description"),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (id == null) {
                      addNote();
                    } else {
                      updateNote();
                    }

                    titleTextController.text = "";
                    descriptionTextController.text = "";

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: Colors.blue, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      id == null ? "Create Note" : "Update",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _refreshNote();

    debugPrint("Number of notes: ${notes.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQL"),
        elevation: 0,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
