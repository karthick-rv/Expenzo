class Expense {
  String name = "";
  String? description = "";
  int amount = 0;
  DateTime date = DateTime.now();
  ExpenseCategory category = ExpenseCategory.miscellaneous;

  Expense({required this.name,this.description, required this.amount, required this.date, required this.category});
}


enum ExpenseCategory {food, rent, dress, travel, entertainment, miscellaneous}