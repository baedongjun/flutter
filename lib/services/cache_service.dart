import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheService {
  static const String KEY_USER_PROFILE = 'user_profile';
  static const String KEY_DROPIN_HISTORY = 'dropin_history';
  
  final SharedPreferences _prefs;
  
  CacheService(this._prefs);
  
  static Future<CacheService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return CacheService(prefs);
  }

  Future<void> cacheUserProfile(Map<String, dynamic> profile) async {
    await _prefs.setString(KEY_USER_PROFILE, jsonEncode(profile));
  }

  Map<String, dynamic>? getCachedUserProfile() {
    final String? data = _prefs.getString(KEY_USER_PROFILE);
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> clearCache() async {
    await _prefs.clear();
  }
} 