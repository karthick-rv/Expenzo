

import 'package:expenzo/core/resources/data_state.dart';
import 'package:expenzo/features/expense/data/expense.dart';
import 'package:expenzo/features/expense/data/expense_repository.dart';

class ExpenseRepositoryImpl extends ExpenseRepository{
  @override
  Future<DataState<List<Expense>>> addExpense(Expense expense) {
    // TODO: implement addExpense
    throw UnimplementedError();
  }

  @override
  Future<DataState<Expense>> editExpense(Expense expense) {
    // TODO: implement editExpense
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<Expense>>> getExpenses() {
    // TODO: implement getExpenses
    throw UnimplementedError();
  }

}