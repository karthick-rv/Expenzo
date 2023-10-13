import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../data/expense.dart';

class ExpenseEntity extends Equatable {
  // final UniqueKey id = UniqueKey();
  final String name;
  final String? description;
  final int amount;
  DateTime date = DateTime.now();
  final ExpenseCategory category ;

  ExpenseEntity({this.name = "",this.description = "", this.amount = 0, required this.date, this.category = ExpenseCategory.miscellaneous});

  @override
  List<Object?> get props => [name];

  factory ExpenseEntity.fromExpenseModel(ExpenseModel expenseModel){
    return ExpenseEntity(
      name: expenseModel.name ?? "",
      description: expenseModel.description ?? "",
      amount: expenseModel.amount ?? 0,
      date:  DateFormat("yyyy-MM-dd").parse(expenseModel.date ?? ""),
      category: expenseModel.category != null ? ExpenseCategory.values.firstWhere((element) => element.name == expenseModel.category) : ExpenseCategory.miscellaneous
    );
  }
}


enum ExpenseCategory {food, rent, dress, travel, entertainment, miscellaneous}