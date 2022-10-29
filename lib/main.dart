import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/entrycard.dart';
import './widgets/InputForm.dart';
import './widgets/chart.dart';

import './models/entry.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  Hive.registerAdapter(EntryAdapter());
  await Hive.initFlutter();
  await Hive.openBox("Entry");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xpense',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
            titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 2, 61, 70),
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.cyan)),
        scrollbarTheme: ScrollbarThemeData(
            thumbColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor)),
      ),
      home:
          SplashScreen(), //when external data supplied to widget , build is called automatically
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MyHomePage(),
      duration: 5000,
      imageSize: 70,
      imageSrc: "assets/images/icon.png",
      text: "Xpense",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      colors: const [
        Colors.cyan,
        Colors.blue,
        Colors.purple,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var box = Hive.box('Entry');

  List<Entry> getBoxEntry() {
    List<Entry> entries = (box.values.toList() as List<dynamic>)
        .map((dynamic item) => item as Entry)
        .toList();
    return entries;
  }

  void _addEntry(String enTitle, double enAmount, DateTime selectedDate) async {
    final newEntry = Entry(
        id: DateTime.now().toString(),
        title: enTitle,
        amount: enAmount,
        date: selectedDate);

    setState(() {
      box.add(newEntry);
    });
  }

  void _editEntry(int index, Entry value) {
    setState(() {
      box.putAt(index, value);
    });
  }

  void _deleteEntry(int index) {
    setState(() {
      box.deleteAt(index);
    });
  }

  void addEntryModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: ctx,
        builder: (_) {
          return SizedBox(
            child: InputForm(
              addEntry: _addEntry,
            ),
          );
        });
  }

  List<Entry> get recentEntries {
    //to get entries of last 7 days
    List<Entry> entries = getBoxEntry();
    return entries
        .where((item) =>
            item.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 191, 221, 224),
        elevation: 0,
        title: const Text('Xpense'),
        actions: [
          IconButton(
              onPressed: () {
                addEntryModalSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 191, 221, 224),
        child: Column(
          children: [
            Chart(recentEntries),
            Container(
              padding: EdgeInsets.all(20),
              child: const Text(
                "Expense List",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 61, 70)),
              ),
            ),
            EntryCard(
                entries: getBoxEntry().reversed.toList(),
                deleteEntry: _deleteEntry,
                editEntry: _editEntry)
          ],
        ),
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
