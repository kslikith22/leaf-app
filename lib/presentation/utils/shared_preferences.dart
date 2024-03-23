import 'package:shared_preferences/shared_preferences.dart';

class Prefernces {
  late SharedPreferences _prefs;
  final String _introStatus = "Intro Completed";

  Future<void> initializeSharedPrefernces() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setIntroStatus({required bool value}) async {
    _prefs.setBool(_introStatus, value);
  }

  bool getIntroStatus() {
    return _prefs.getBool(_introStatus) ?? false;
  }

  void setToken({required token}) async {
    _prefs.setString("token", token);
  }

  String getToken() {
    return _prefs.getString("token") ?? '';
  }
}
