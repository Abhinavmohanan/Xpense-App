import 'package:flutter/material.dart';
import './widgets/entrycard.dart';
import './models/entry.dart';
import './widgets/InputForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home:
          MyHomePage(), //when external data supplied to widget , build is called automatically
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Entry> entries = [
    Entry(
        id: "1",
        title: "First Entry is the largest entry ever",
        amount: 1000,
        date: DateTime.now()),
    Entry(id: "2", title: "Second Entry", amount: 500, date: DateTime.now()),
    Entry(id: '3', title: "Thrid Entry", amount: 500, date: DateTime.now()),
  ];

  void _addEntry(String enTitle, double enAmount) {
    final newEntry = Entry(
        id: DateTime.now().toString(),
        title: enTitle,
        amount: enAmount,
        date: DateTime.now());

    setState(() {
      entries.add(newEntry);
    });
  }

  void addEntryModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return InputForm(
            addEntry: _addEntry,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xpense'),
        actions: [
          IconButton(
              onPressed: () {
                addEntryModalSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: Card(
              // Card occupy space of child , unless there is parent with well defined size
              // ignore: sort_child_properties_last
              child: Container(
                alignment: Alignment.center,
                child: const Text("Chart"),
              ),
              elevation: 5,
            ),
          ),
          EntryCard(entries: List.from(entries.reversed)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            addEntryModalSheet(context);
          },
        ),
      ),
    );
  }
}
