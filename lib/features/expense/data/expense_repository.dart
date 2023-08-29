

import 'package:expenzo/features/expense/data/expense.dart';

import '../../../core/resources/data_state.dart';

abstract class ExpenseRepository{

  Future<DataState<List<Expense>>> getExpenses();

  void addExpense(Expense expense);

  Future<DataState<Expense>> editExpense(Expense expense);

}