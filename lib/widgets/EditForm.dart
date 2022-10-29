import '../models/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditForm extends StatefulWidget {
  //The widget
  final Function? editEntry;
  static final _formKey = GlobalKey<FormState>();
  final int? editIndex;
  final List<String> initialValue;

  EditForm({this.editEntry, this.editIndex, required this.initialValue});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  //The state
  late String prevTitle;
  final titleController = TextEditingController();
  //titlecontroller is made a texteditingcontroller , that will never change but its properties like .text can change
  final amountController = TextEditingController();
  bool flag = false;

  DateTime selectedDate = DateTime.now();

  _validateAmount() {
    if (EditForm._formKey.currentState!.validate()) {
      final newEntry = Entry(
          id: DateTime.now().toString(),
          title: titleController.text,
          amount: double.parse(amountController.text),
          date: selectedDate);
      widget.editEntry!(
          widget.editIndex, newEntry); //Calls addEntry from widget class above
      Navigator.of(context).pop(); //Close Modalsheet after entry
    }
  }

  datePicker() async {
    DateTime? pickeDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());
    if (pickeDate != null) {
      //On cancel null is recieved
      setState(() {
        selectedDate = pickeDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) {
      //flag for running once only
      flag = true;
      titleController.text = widget.initialValue[0];
      amountController.text = widget.initialValue[1];
    }

    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.fromLTRB(11, 0, 11, 0),
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
        child: Form(
          key: EditForm._formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  validator: ((value) {
                    if (value == "") {
                      return "Enter Title";
                    } else {
                      return null;
                    }
                  }),
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: titleController,
                  onFieldSubmitted: (_) => _validateAmount(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  validator: ((value) {
                    try {
                      double value1 = double.parse(value!);
                      if (value1 <= 0) {
                        return "Enter a valid amount";
                      }
                      return null;
                    } on FormatException {
                      return "Enter a valid amount";
                    }
                  }),
                  decoration: const InputDecoration(
                    labelText: "Amount",
                  ),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) => _validateAmount(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(DateFormat("yMMMd").format(selectedDate)),
                  const SizedBox(
                    width: 1,
                  ),
                  IconButton(
                    onPressed: () {
                      datePicker();
                    },
                    icon: Icon(Icons.calendar_month_outlined,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: _validateAmount, child: const Text("Edit Entry"))
            ],
          ),
        ),
      ),
    );
  }
}
