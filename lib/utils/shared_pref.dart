import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotrial/api/firebase_api.dart';

class Shared_Pref {
  static SharedPreferences _pref;
  static Future init() async {
    _pref = await SharedPreferences.getInstance();
    FirebaseApi.UserID = _pref.getString('UID') ?? "";

    FirebaseApi.UserName = _pref.getString('UName') ?? "";
    FirebaseApi.UserPhotoURL = _pref.getString('UPhoto') ?? "";
    FirebaseApi.UisLoggedIn = _pref.getBool('isLoggedIn') ?? false;
  }

  static Future SetUID(
      String username, String uName, String uPhoto, bool log) async {
    await _pref.setString('UID', username);
    await _pref.setString('UName', uName);
    await _pref.setString('UPhoto', uPhoto);
    await _pref.setBool('isLoggedIn', log);
  }

  static Future GetIsLogged(update) {
    update(_pref.getBool('isLoggedIn') ?? false);
  }
}
