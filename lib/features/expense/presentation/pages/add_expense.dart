import 'dart:ffi';

import 'package:expenzo/features/expense/data/expense.dart';
import 'package:expenzo/features/expense/presentation/widgets/date_picker.dart';
import 'package:expenzo/features/expense/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

List<String> list = ExpenseCategory.values.map((e) => e.name).toList();

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddExpensePageState();
  }
}

class AddExpensePageState extends State<AddExpensePage> {
  // late TextEditingController _controller;
  String dropdownValue = list.first;
  String name = "";
  String desc = "";
  int amount = 0;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Expense'),
          ),
            body: Padding(
              padding: const EdgeInsets.all(50),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   CustomTextField(name: "Name", onChanged: (String text) => {
                     name = text
                   }),
                    CustomTextField(name: "Description", onChanged: (String text) => {
                      desc = text
                    }),
                    CustomTextField(name: "Amount", onChanged: (String text) => {
                      amount = text as int
                    }),
                    const SizedBox(height: 50),
                    DatePicker(onDatePicked: (date) => {setState(()=>{selectedDate = date})}),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text("Expense Category"),
                        const SizedBox(width: 50),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () => {
                          Expense(name: name, description: desc, amount: amount, date: selectedDate, category: ExpenseCategory.values.firstWhere((element) => element.name == dropdownValue))
                        }, child: const Text("Add Expense"))
                  ],
                ),
              ),
            ),
          ),
        );
    });
  }
}
