import 'package:flutter/material.dart';
import './entrycard.dart';

class InputForm extends StatelessWidget {
  final Function? addEntry;
  final titleController =
      TextEditingController(); //titlecontroller is made a texteditingcontroller , that will never change but its properties like .text can change
  final amountController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  InputForm({this.addEntry});

  ValidateAmount() {
    if (_formKey.currentState!.validate()) {
      addEntry!(titleController.text, double.parse(amountController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(11, 0, 11, 0),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
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
                  onFieldSubmitted: (_) => ValidateAmount(),
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
                  onFieldSubmitted: (_) => ValidateAmount(),
                ),
              ),
              ElevatedButton(
                  onPressed: ValidateAmount, child: const Text("Add Entry"))
            ],
          ),
        ),
      ),
    );
  }
}
