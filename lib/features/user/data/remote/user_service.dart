

import 'package:dio/dio.dart' hide Headers;
import 'package:expenzo/features/user/data/user_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants.dart';
part 'user_service.g.dart';

@RestApi(baseUrl:expenseAPIBaseURL)
abstract class UserService{

  factory UserService(Dio dio) = _UserService;

  @POST('/user/create')
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<HttpResponse<void>> signUp(@Body() UserRequest userRequest);

  @POST('/user')
  @Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<HttpResponse<UserResponse>> signIn(@Body() UserRequest userRequest);

}