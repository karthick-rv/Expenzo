

import 'package:expenzo/core/resources/data_state.dart';
import 'package:expenzo/features/user/data/user_model.dart';

abstract class UserRepository{

  Future<DataState<void>> signUp(UserRequest userRequest);
  Future<DataState<UserResponse>> signIn(UserRequest userRequest);
  Future<DataState<bool>> logOut();
}