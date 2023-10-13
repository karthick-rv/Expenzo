

import '../../domain/expense.dart';

abstract class ExpenseEvent{

  final ExpenseEntity? expense;

  const ExpenseEvent({this.expense});
}

class GetExpenses extends ExpenseEvent{
  const GetExpenses();
}

class AddExpense extends ExpenseEvent{
  const AddExpense(ExpenseEntity expense): super(expense: expense);
}

class EditExpense extends ExpenseEvent{
  const EditExpense(ExpenseEntity expense): super(expense: expense);
}


class LogOutEvent extends ExpenseEvent{
  LogOutEvent();
}
