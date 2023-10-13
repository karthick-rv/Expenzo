import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expenzo/core/resources/data_state.dart';
import 'package:expenzo/features/expense/data/expense.dart';
import 'package:expenzo/features/expense/data/local/expense_dao.dart';
import 'package:expenzo/features/expense/data/remote/expense_api_service.dart';
import 'package:expenzo/features/expense/domain/expense.dart';
import 'package:expenzo/features/expense/data/expense_repository.dart';
import 'package:expenzo/features/user/data/local/user_preferences.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseDao expenseDao;
  ExpenseApiService expenseApiService;
  List<ExpenseEntity> expenseList = [];

  ExpenseRepositoryImpl(
      {required this.expenseDao, required this.expenseApiService});

  @override
  Future<DataState<void>> addExpense(ExpenseEntity expense) async {
    try {
      var authToken = await UserPreferences().getAccessToken();
      await expenseApiService.addExpense("Bearer $authToken", ExpenseModel.fromEntity(expense));
      return const DataSuccess(null);
    } on DioException catch (e) {
      return const DataFailed(null, "Exception - Error adding expense, Try later");
    }
  }

  @override
  Future<DataState<ExpenseEntity>> editExpense(ExpenseEntity expense) {
    // TODO: implement editExpense
    throw UnimplementedError();
  }

  Future<List<ExpenseEntity>> fetchLocalExpenses() async{
    var expenses = await expenseDao.getExpenses();

    List<ExpenseEntity> entities = expenses
        .map((ExpenseModel e) => ExpenseEntity.fromExpenseModel(e))
        .toList();

    return entities;
  }

  @override
  Future<DataState<List<ExpenseEntity>>> getExpenses() async {
    try {
      var authToken = await UserPreferences().getAccessToken();
      final httpResponse = await expenseApiService.getExpenses("Bearer $authToken");
      await expenseDao.deleteAll();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final futureExpenses = httpResponse.data.map((e) async{
          await expenseDao.insertExpense(e);
        });

        Future.wait(futureExpenses);

        final expenseEntities = await fetchLocalExpenses();

        return DataSuccess(expenseEntities);
      } else {
        final expenseEntities = await fetchLocalExpenses();
        return DataFailed(expenseEntities, "Api Failed - Showing Local data");
      }
    } on DioException catch (e) {
      final expenseEntities = await fetchLocalExpenses();
      return DataFailed(expenseEntities, "Exception - Showing Local data");
    }
  }
}
