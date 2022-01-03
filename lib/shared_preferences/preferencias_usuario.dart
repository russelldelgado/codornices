import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static final Preferencias _instance = Preferencias._internal();
  factory Preferencias() {
    return _instance;
  }
  Preferencias._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int get userIdget {
    return _prefs.getInt("userId") ?? 0;
  }

  set userIdgetSet(int userId) {
    _prefs.setInt("userId", userId);
  }
}
