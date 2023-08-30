import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Expense extends Equatable {
  final UniqueKey id = UniqueKey();
  final String name;
  final String? description;
  final int amount;
  DateTime date = DateTime.now();
  final ExpenseCategory category ;

  Expense({this.name = "",this.description = "", this.amount = 0, required this.date, this.category = ExpenseCategory.miscellaneous});

  @override
  List<Object?> get props => [name];
}


enum ExpenseCategory {food, rent, dress, travel, entertainment, miscellaneous}