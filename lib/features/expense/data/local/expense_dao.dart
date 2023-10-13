


import 'package:expenzo/features/expense/data/expense.dart';
import 'package:floor/floor.dart';

@dao
abstract class ExpenseDao {

  @insert
  Future<void> insertExpense(ExpenseModel expense);

  @Query("SELECT * FROM expense")
  Future<List<ExpenseModel>> getExpenses();

  @Query("DELETE FROM expense")
  Future<void> deleteAll();

}