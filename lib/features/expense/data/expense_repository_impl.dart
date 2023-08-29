

import 'dart:math';

import 'package:expenzo/core/resources/data_state.dart';
import 'package:expenzo/features/expense/data/expense.dart';
import 'package:expenzo/features/expense/data/expense_repository.dart';

class ExpenseRepositoryImpl extends ExpenseRepository{

  List<Expense> expenseList = [];

  @override
  void addExpense(Expense expense) {
     expenseList.add(expense);
  }

  @override
  Future<DataState<Expense>> editExpense(Expense expense) {
    // TODO: implement editExpense
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<Expense>>> getExpenses() {
    return Future.value(DataSuccess(expenseList));
  }

}