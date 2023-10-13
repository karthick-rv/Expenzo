

class UserEntity{
  final String email;
  final String token;
  final bool isSignIn;

  const UserEntity({required this.email, required this.token, this.isSignIn = false});
}
