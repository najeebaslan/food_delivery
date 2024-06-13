import 'helper_shared_preferences.dart';

abstract class BaseHelperUser {
  void saveUserId(String userId);
  Future<String?> getUserId();

  void saveUserName(String name);
  Future<String?> getUserName();

  void saveIsAdmin(bool isAdmin);
  Future<bool> getIsAdmin();

  void saveIsAuthorized(bool isAuthorized);
  Future<bool> getAuthorized();

  void saveUserImage(String image);
  Future<String?> getUserImage();

  void saveEmail(String email);
  Future<String?> getEmail();
}

class HelperUser implements BaseHelperUser {
  static const String _keyEmail = 'KEY_EMAIL';
  static const String _keyUserId = 'KEY_USER_ID';
  static const String _keyImage = 'KEY_USER_IMAGE';
  static const String _keyIsAdmin = 'KEY_USER_IS_ADMIN';
  static const String _keyIsAuthorized = 'KEY_USER_IS_AUTHORIZED';
  static const String _keyName = 'KEY_USER_NAME';

  @override
  Future<String?> getEmail() async {
    return await HelperSharedPreferences.getString(_keyEmail);
  }

  @override
  Future<String?> getUserId() async {
    return await HelperSharedPreferences.getString(_keyUserId);
  }

  @override
  void saveEmail(String email) async {
    await HelperSharedPreferences.setString(_keyEmail, email);
  }

  @override
  void saveUserId(String userId) async {
    await HelperSharedPreferences.setString(_keyUserId, userId);
  }

  @override
  Future<String?> getUserImage() async {
    return await HelperSharedPreferences.getString(_keyImage);
  }

  @override
  void saveUserImage(String image) async {
    await HelperSharedPreferences.setString(_keyImage, image);
  }

  @override
  Future<bool> getIsAdmin() async {
    return await HelperSharedPreferences.getBool(_keyIsAdmin) ?? false;
  }

  @override
  void saveIsAdmin(bool isAdmin) async {
    await HelperSharedPreferences.setBool(_keyIsAdmin, isAdmin);
  }

  @override
  Future<bool> getAuthorized() async {
    return await HelperSharedPreferences.getBool(_keyIsAuthorized) ?? false;
  }

  @override
  void saveIsAuthorized(bool isAuthorized) async {
    await HelperSharedPreferences.setBool(_keyIsAuthorized, isAuthorized);
  }

  @override
  Future<String?> getUserName() async {
    return await HelperSharedPreferences.getString(_keyName);
  }

  @override
  void saveUserName(String name) async {
    await HelperSharedPreferences.setString(_keyName, name);
  }
}
