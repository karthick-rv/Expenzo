
import 'package:expenzo/features/user/data/user_model.dart';

abstract class AuthEvent{
  final UserRequest? user;
  const AuthEvent([this.user]);
}

class SignUpEvent extends AuthEvent{
  SignUpEvent({required user}): super(user);
}

class SignInEvent extends AuthEvent{
  SignInEvent({required user}): super(user);
}