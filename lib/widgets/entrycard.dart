import 'package:flutter/material.dart';
import 'package:xpense/main.dart';
import '../models/entry.dart';
import 'package:intl/intl.dart';
import './InputForm.dart';
import 'package:hive/hive.dart';

class EntryCard extends StatelessWidget {
  final List<Entry> entries;
  final Function deleteEntry;

  EntryCard({required this.entries, required this.deleteEntry});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: entries.isEmpty
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 100,
                    alignment: Alignment.center,
                    child: const Text("No entries added yet",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                      height: 200,
                      child: Image.asset("assets/images/waiting.png",
                          fit: BoxFit.contain)),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    child: Card(
                      shadowColor: Colors.blueAccent,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: const EdgeInsets.all(8),
                      elevation: 3,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 2)),
                            padding: const EdgeInsets.all(3),
                            width: 100,
                            height: 45,
                            margin: const EdgeInsets.all(11),
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text(
                                "₹${entries[index].amount.toStringAsFixed(0)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  entries[index].title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(entries[index].date),
                                  // "${eachEntry.date.day}/${eachEntry.date.month}/${eachEntry.date.year}",
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 142, 141, 141)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {
                                  deleteEntry(entries.length - index - 1);
                                },
                                alignment: Alignment.center,
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).errorColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: entries.length,
              ));
  }
}
