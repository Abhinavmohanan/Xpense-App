import 'package:flutter/material.dart';
import 'package:xpense/main.dart';
import '../models/entry.dart';
import 'package:intl/intl.dart';
import './InputForm.dart';

class EntryCard extends StatelessWidget {
  final List<Entry> entries;

  EntryCard({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
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
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(
                              color: Color.fromARGB(255, 9, 93, 162),
                              width: 2)),
                      padding: EdgeInsets.all(3),
                      width: 100,
                      height: 45,
                      margin: EdgeInsets.all(11),
                      alignment: Alignment.center,
                      child: Text(
                        "₹${entries[index].amount.toStringAsFixed(0)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 17, 90, 149)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child: Text(
                            entries[index].title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                          Text(
                            DateFormat.yMMMd().format(entries[index].date),
                            // "${eachEntry.date.day}/${eachEntry.date.month}/${eachEntry.date.year}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 142, 141, 141)),
                          )
                        ],
                      ),
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
