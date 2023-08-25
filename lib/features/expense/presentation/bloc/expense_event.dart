

import '../../data/expense.dart';

abstract class ExpenseEvent{

  final Expense? expense;

  const ExpenseEvent({this.expense});
}

class GetExpenses extends ExpenseEvent{
  const GetExpenses();
}

class AddExpense extends ExpenseEvent{
  const AddExpense(Expense expense): super(expense: expense);
}

class EditExpense extends ExpenseEvent{
  const EditExpense(Expense expense): super(expense: expense);
}