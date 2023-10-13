
import 'package:expenzo/features/expense/data/expense.dart';
import 'package:expenzo/features/expense/data/local/expense_dao.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';


@Database(version: 1, entities:[ExpenseModel])
abstract class AppDatabase extends FloorDatabase{
  ExpenseDao get expenseDAO;
}