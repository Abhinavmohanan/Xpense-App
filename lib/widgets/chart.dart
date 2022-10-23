import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpense/widgets/Chart_Bar.dart';
import '../models/entry.dart';

class Chart extends StatelessWidget {
  var recentEntries;

  Chart(this.recentEntries);

  List<Map<String, Object>> get mapRecentEntries {
    return List.generate(7, (index) {
      double sum = 0;
      DateTime date = DateTime.now().subtract(Duration(days: index));

      for (var item in recentEntries) {
        if (item.date.day == date.day &&
            item.date.year == date.year &&
            item.date.month == date.month) {
          sum += item.amount;
        }
      }

      return {
        "day": DateFormat("E").format(date).substring(0, 1),
        "amount": sum
      };
    }).reversed.toList();
  }

  double get totalSum {
    double totalSum = 0;

    return mapRecentEntries.fold(0.0,
        (previousValue, item) => previousValue += (item["amount"] as double));
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 12, top: 3),
              child: const Text(
                "Last Week: ",
                style: TextStyle(fontSize: 20, fontFamily: 'QuickSand'),
              ),
            ),
            Row(
              children: mapRecentEntries.map((item) {
                return ChartBar(
                    item["day"].toString(),
                    item["amount"] as double,
                    totalSum == 0
                        ? 0.0
                        : (item["amount"] as double) / totalSum);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
