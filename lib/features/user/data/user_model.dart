class UserResponse {

  final String email;
  final String token;

  UserResponse({required this.email, required this.token});

  factory UserResponse.fromJson(Map<String, dynamic> map){
    return UserResponse(
        email: map["email"],
        token: map["token"],
    );
  }
}

class UserRequest{

  final String email;
  final String password;

  UserRequest({required this.email, required this.password});

  Map<String, dynamic> toJson(){
    return {
      "email": email,
      "password": password,
    };
  }
}