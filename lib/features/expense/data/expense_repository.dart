

import 'package:expenzo/features/expense/data/local/app_database.dart';
import 'package:expenzo/features/expense/domain/expense.dart';

import '../../../core/resources/data_state.dart';

abstract class ExpenseRepository{

  Future<DataState<List<ExpenseEntity>>> getExpenses();

  Future<DataState<void>> addExpense(ExpenseEntity expense);

  Future<DataState<ExpenseEntity>> editExpense(ExpenseEntity expense);

}