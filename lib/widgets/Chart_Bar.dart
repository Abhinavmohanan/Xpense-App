import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String day;
  double amount;
  double fractionpercent;

  ChartBar(this.day, this.amount, this.fractionpercent);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: FittedBox(
                child: Text(
              "₹${amount.toStringAsFixed(0)}",
              style: const TextStyle(
                  fontFamily: 'QuickSand', fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 60,
            width: 10,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 207, 199, 199),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                FractionallySizedBox(
                  heightFactor: fractionpercent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            child: Text(day),
          ),
        ],
      ),
    );
  }
}
