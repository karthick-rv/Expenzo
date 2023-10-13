

import 'package:dio/dio.dart';
import 'package:expenzo/features/user/data/local/user_preferences.dart';
import 'package:expenzo/features/user/data/remote/user_service.dart';
import 'package:expenzo/features/user/data/user_model.dart';
import 'package:expenzo/features/user/data/user_repository.dart';

import '../../../core/resources/data_state.dart';

class UserRepositoryImpl extends UserRepository{

  UserService userService;

  UserRepositoryImpl({required this.userService}) : super();

  @override
  Future<DataState<void>> signUp(UserRequest userRequest) async{
    try{
       await userService.signUp(userRequest);
       return const DataSuccess(null);
    }on DioException catch (e){
      return const DataFailed(null, "Exception - Error Signing up, Try later");
    }
  }

  @override
  Future<DataState<UserResponse>> signIn(UserRequest userRequest) async {
    try{
      var userResponse = await userService.signIn(userRequest);
      return DataSuccess(userResponse.data);
    }on DioException catch (e){
      return const DataFailed(null, "Exception - Error Signing in, Try later");
    }
  }


  @override
  Future<DataState<bool>> logOut() async {
    try{
      var tokenRemoved = await UserPreferences().removeAccessToken();
      if(tokenRemoved){
        return const DataSuccess(true);
      }else{
        return const DataFailed(null, "Token removal unsuccessful");
      }

    }on DioException catch (e){
      return const DataFailed(null, "Exception - Error Signing in, Try later");
    }
  }

}