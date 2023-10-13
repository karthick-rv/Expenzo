

import 'package:dio/dio.dart' hide Headers;
import 'package:expenzo/core/constants.dart';
import 'package:expenzo/features/expense/data/expense.dart';
import 'package:retrofit/retrofit.dart';
part 'expense_api_service.g.dart';

@RestApi(baseUrl:expenseAPIBaseURL)
abstract class ExpenseApiService {
  factory ExpenseApiService(Dio dio)  = _ExpenseApiService;

  @GET('/expenses')
  Future<HttpResponse<List<ExpenseModel>>> getExpenses(@Header('Authorization') String? authToken);

  @POST('/expense')
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<void> addExpense(@Header('Authorization') String? authToken, @Body() ExpenseModel expenseModel);
}