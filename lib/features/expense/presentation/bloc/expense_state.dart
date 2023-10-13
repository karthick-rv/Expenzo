import 'package:equatable/equatable.dart';

import '../../domain/expense.dart';

abstract class ExpenseState extends Equatable {
  final List<ExpenseEntity>? expenses;
  final String? error;

  const ExpenseState({this.expenses, this.error});

  @override
  List<Object?> get props {
    return [expenses];
  }
}

class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

class ExpenseSuccess extends ExpenseState {
  const ExpenseSuccess(List<ExpenseEntity> expenses)
      : super(expenses: expenses);
}

class ExpenseError extends ExpenseState {
  const ExpenseError(List<ExpenseEntity> localExpenses, String errorMsg)
      : super(expenses: localExpenses, error: errorMsg);
}

class AddExpenseSuccess extends ExpenseState{

}

class AddExpenseError extends ExpenseState{
  const AddExpenseError(String errorMsg): super(error: errorMsg);
}

class AddExpenseLoading extends ExpenseState{
  
}

class LogOutSuccess extends ExpenseState{}
class LogOutError extends ExpenseState{}
class LogOutLoading extends ExpenseState{}