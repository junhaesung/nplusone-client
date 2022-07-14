import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageApi {
  const TokenStorageApi();

  final _key = 'NPLUSONE_API_ACCESS_TOKEN';

  Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  Future<void> write(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, accessToken);
  }

  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}