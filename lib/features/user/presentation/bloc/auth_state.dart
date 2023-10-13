

import 'package:equatable/equatable.dart';
import 'package:expenzo/features/user/domain/user_entity.dart';

abstract class AuthState extends Equatable{

  final UserEntity? userEntity;
  final String? error;

  const AuthState({this.userEntity, this.error});

  @override
  List<Object> get props {
    return [userEntity!];
  }
}

class AuthLoading extends AuthState{
  const AuthLoading();
}

class AuthInit extends AuthState{
  const AuthInit();
}

class AuthSuccess extends AuthState{
  const AuthSuccess({userEntity}):super(userEntity: userEntity);
}

class AuthError extends AuthState{
  const AuthError({super.error});
}