import 'package:expenzo/features/expense/domain/expense.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "expense")
class ExpenseModel {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? name;
  String? description;
  int? amount;
  String? date;
  String? category;
  ExpenseModel({
    this.id,
    this.name,
    this.description,
    this.amount,
    this.date,
    this.category});


  factory ExpenseModel.fromJson(Map<String, dynamic> map){
    return ExpenseModel(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      amount: map["amount"],
      date: map["date"],
      category: map["category"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "description": description,
      "amount": amount,
      "date": date,
      "category": category
    };
  }


  factory ExpenseModel.fromEntity(ExpenseEntity expenseEntity){
    return ExpenseModel(
      name: expenseEntity.name,
      description: expenseEntity.description,
      amount: expenseEntity.amount,
      date: expenseEntity.date.toLocal().toString().split(" ")[0],
      category: expenseEntity.category.name
    );
  }
}