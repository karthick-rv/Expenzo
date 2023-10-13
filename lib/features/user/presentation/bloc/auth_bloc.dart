
import 'package:expenzo/core/resources/data_state.dart';
import 'package:expenzo/features/user/data/local/user_preferences.dart';
import 'package:expenzo/features/user/presentation/bloc/auth_event.dart';
import 'package:expenzo/features/user/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_repository.dart';
import '../../domain/user_entity.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{

  late final UserRepository userRepository;

  AuthBloc(this.userRepository) : super(const AuthInit()){
    on <SignUpEvent> (onSignUpEvent);
    on <SignInEvent> (onSignInEvent);
  }

  void onSignInEvent(SignInEvent event, Emitter<AuthState> emitter) async{
    // do api call
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    var userData = await userRepository.signIn(event.user!);

    if(userData is DataSuccess){
      var user = userData.data!;
      var userPref =  UserPreferences();
     userPref.storeAccessToken(user.token);
     userPref.storeEmail(user.email);
      emit(AuthSuccess(userEntity: UserEntity(email: user.email, token: user.token, isSignIn: true)));
    }else{
      emit(AuthError(error: userData.error));
    }
  }

  void onSignUpEvent(SignUpEvent event, Emitter<AuthState> emitter) async{
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    var result = await userRepository.signUp(event.user!);
    if(result is DataSuccess){
      emit(const AuthSuccess());
    }else{
      emit(const AuthError());
    }
  }
}