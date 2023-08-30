

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/expense.dart';

abstract class ExpenseState extends Equatable{

  final List<Expense>? expenses;
  final DioException? error;

  const ExpenseState({this.expenses, this.error});

  @override
  List<Object> get props {
    return [expenses!];
  }
}


class ExpenseLoading extends ExpenseState{
  const ExpenseLoading();
}

class ExpenseSuccess extends ExpenseState{
  const ExpenseSuccess(List<Expense> expenses) : super(expenses: expenses);
}

class ExpenseError extends ExpenseState{
  const ExpenseError(DioException error) : super(error: error);
}
