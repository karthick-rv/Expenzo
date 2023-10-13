
import 'package:shared_preferences/shared_preferences.dart';



class UserPreferences{

  late final Future<SharedPreferences> _prefs;
  static UserPreferences? _instance;
  static const _userAccessToken = "USER_ACCESS_TOKEN";
  static const _email = "EMAIL";


  UserPreferences._() {
    _prefs = SharedPreferences.getInstance();
  }

  factory UserPreferences() {
    _instance ??= UserPreferences._();
    return _instance!;
  }

  void storeAccessToken(token) async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(_userAccessToken, token);
  }

  Future<bool> removeAccessToken() async{
    final SharedPreferences prefs = await _prefs;
    return await prefs.remove(_userAccessToken);
  }

  void storeEmail(String email) async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(_email, email);
  }

  Future<String?> getAccessToken() async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_userAccessToken);
  }

  Future<String?> getEmail() async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_email);
  }
}