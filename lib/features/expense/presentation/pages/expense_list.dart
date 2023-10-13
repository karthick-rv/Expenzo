import 'package:expenzo/features/expense/domain/expense.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzo/features/expense/presentation/bloc/expense_state.dart';
import 'package:expenzo/features/expense/presentation/pages/add_expense.dart';
import 'package:expenzo/features/expense/presentation/widgets/pie_chart.dart';
import 'package:expenzo/features/user/data/local/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:collection/collection.dart";

import '../../../user/presentation/pages/auth.dart';

class ExpenseList extends StatefulWidget {

  const ExpenseList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ExpenseListState();
  }
}

class ExpenseListState extends State<ExpenseList> {

  String email = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: buildAppbar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.background
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: buildBody(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
    getEmail().then((value){
      setState(() {
        email = value!;
      });
    }
    );
  }

  Future<String?> getEmail() async{
    return await UserPreferences().getEmail();
  }

  _fetchExpenses() {
    context.read<ExpenseBloc>().add(const GetExpenses());
  }

  showSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SnackBar snackBar = SnackBar(
        content: Text(message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Map<ExpenseCategory, List<ExpenseEntity>> _segregateExpenses(List<ExpenseEntity> expenses) {
    var map = groupBy(expenses, (expense) => expense.category);
    print(map);
    return map;
  }

  AppBar buildAppbar() {

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      title: const Text('Expenses', style: TextStyle(fontSize: 20)),
      actions: [
        Text(email, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        const SizedBox(width: 20,),
        OutlinedButton(onPressed: (){
          context
              .read<ExpenseBloc>()
              .add(LogOutEvent());
        }, child: Text("Logout", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)),
        const SizedBox(width: 20)
      ],
    );
  }

  Widget buildBody() {
    return BlocConsumer<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ExpenseLoading:
            return const Center(child: CircularProgressIndicator());
          case ExpenseSuccess:
            var segregatedExpenses = _segregateExpenses(state.expenses!);
            return Column(
              children: [topBar(), PieChartWidget(expenseMap: segregatedExpenses), expenseList(state)],
            );
          case ExpenseError:
            return Column(
              children: [topBar(), expenseList(state)],
            );
          case LogOutLoading:
            return const Center(child: CircularProgressIndicator());
          default:
            return Column(
              children: [topBar(), expenseList(state)],
            );
        }
      },
      listener: (context, state) {
        switch (state.runtimeType) {
          case ExpenseError:
            showSnackBar(state.error!);
            break;
          case AddExpenseError:
            _fetchExpenses();
            showSnackBar(state.error!);
            break;
          case AddExpenseSuccess:
            _fetchExpenses();
            break;
          case LogOutSuccess:
            Navigator.of(context)
                .push(
                MaterialPageRoute(
                  builder: (context) => const AuthScreen(),
                ));
            showSnackBar("Logout successful");
            break;
          case LogOutError:
            showSnackBar("Logout unsuccessful");
            break;
        }
      },
    );
  }

  Widget expenseList(ExpenseState state) {
    Color textColor = Theme.of(context).colorScheme.background;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: state.expenses?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            var expense = state.expenses![index];
            return Container(
              padding: const EdgeInsets.all(30),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(expense.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400,color: textColor)),
                  Text(expense.category.name,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400,color: textColor)),
                  Text(expense.amount.toString(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold,color: textColor)),
                  Text(expense.date.toLocal().toString().split(" ")[0],
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500,color: textColor)),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 15);
          },
        ),
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
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => const AddExpensePage(),
                ),
              )
                  .whenComplete(() {
                // _fetchExpenses();
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
