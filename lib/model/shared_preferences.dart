import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceshelper {
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }

  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }

  static Future<void> saveUserImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImage', imagePath);
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  static Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userImage');
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userImage');
    await prefs.remove('userEmail');
    await prefs.remove('userId');
  }
}
