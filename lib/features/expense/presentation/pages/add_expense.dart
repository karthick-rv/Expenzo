import 'dart:ffi';

import 'package:expenzo/features/expense/data/expense.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzo/features/expense/presentation/pages/expense_list.dart';
import 'package:expenzo/features/expense/presentation/widgets/date_picker.dart';
import 'package:expenzo/features/expense/presentation/widgets/dropdown.dart';
import 'package:expenzo/features/expense/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> list = ExpenseCategory.values.map((e) => e.name).toList();

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddExpensePageState();
  }
}

class AddExpensePageState extends State<AddExpensePage> {
  String dropdownValue = list.first;
  String name = "";
  String desc = "";
  int amount = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
        child: Scaffold(
          appBar: buildAppBar(),
          body: buildBody(),
        ),
      );
    });
  }


  AppBar buildAppBar(){
    return AppBar(
      title: const Text('Add Expense'),
    );
  }

  Widget buildBody(){
    return Padding(
      padding: const EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
                name: "Name",
                keyboardType: TextInputType.name,
                onChanged: (String text) => {name = text}),
            CustomTextField(
                name: "Description",
                keyboardType: TextInputType.text,
                onChanged: (String text) => {desc = text}),
            CustomTextField(
                name: "Amount",
                keyboardType: TextInputType.number,
                onChanged: (String text) => {amount = int.parse(text)}),
            const SizedBox(height: 50),
            DatePicker(
                selectedDate: selectedDate,
                onDatePicked: (date) => {
                  setState(() {
                    selectedDate = date;
                  })
                }),
            const SizedBox(height: 30),
            Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "Expense Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    DropDown<String>(
                        list: list,
                        dropdownValue: dropdownValue,
                        onValueChanged: (String? value) => {
                          setState(() {
                            dropdownValue = value!;
                          })
                        })
                  ],
                )),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: (){
                 var expense =  Expense(
                      name: name,
                      description: desc,
                      amount: amount,
                      date: selectedDate,
                      category: ExpenseCategory.values.firstWhere(
                              (element) => element.name == dropdownValue));
                  context.read<ExpenseBloc>().add(AddExpense(expense));
                 Navigator.of(context).pop();
                },
                child: const Text("Add Expense"))
          ],
        ),
      ),
    );
  }


}
