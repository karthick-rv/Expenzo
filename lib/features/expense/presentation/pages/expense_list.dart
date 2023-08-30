import 'package:expenzo/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_state.dart';
import 'package:expenzo/features/expense/presentation/pages/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ExpenseListState();
  }
}

class ExpenseListState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }


  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  _fetchExpenses() {
    context.read<ExpenseBloc>().add(const GetExpenses());
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text('Your Expenses'),
    );
  }

  Widget buildBody() {
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
      return Column(
        children: [
          topBar(),
          expenseList(state)
        ],
      );
    });
  }

  Widget expenseList(ExpenseState state) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: state.expenses?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var expense = state.expenses![index];
          return Container(
            padding: const EdgeInsets.all(30),
            color: Colors.amberAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(expense.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400)),
                Text(expense.category.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400)),
                Text(expense.amount.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Text(expense.date.toLocal().toString().split(" ")[0],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddExpensePage(),
                ),
              ).whenComplete((){
                _fetchExpenses();
              });
            },
            child: const Text(
              "Add Expense",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
