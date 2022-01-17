import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtil {

  SharedPrefsUtil._();

  static final SharedPrefsUtil prefsInstance = SharedPrefsUtil._();

  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  Map<String,dynamic> _prefsMap;


  void saveIntToPrefs(String key, int value) async {
    final pref = await _sprefs;
    pref.setInt(key, value);
    pref.commit();
  }


  void saveStringToPrefs(String key, String value) async{
    final pref = await _sprefs;
    pref.setString(key, value);
    pref.commit();
  }

  void saveBoolToPrefs(String key, bool value) async {
    final pref = await _sprefs;
    pref.setBool(key, value);
    pref.commit();
  }


  Future<String> loadStringFromPref (String key) async {
    final pref = await _sprefs;

    var strValue = pref.getString(key) ?? "";

    return strValue;
  }

  Future<int> loadIntFromPref (String key) async {
    final pref = await _sprefs;

    var intValue = pref.getInt(key) ?? -1;

    return intValue;

  }

  Future<bool> loadBoolFromPref (String key) async {
    final pref = await _sprefs;

    var boolVal =  pref.getBool(key);

    return boolVal;

  }


  Future<dynamic> loadFromPrefs (String key) async{

    final pref = await _sprefs;
    _prefsMap =  new HashMap();

    _prefsMap['UserName'] = pref.get(key) ?? "---";
    _prefsMap['PassWord'] = pref.get(key) ?? "---";
    _prefsMap['UserType'] = pref.get(key) ?? "---";
    _prefsMap['MemberId'] = pref.get(key) ?? "---";
    _prefsMap['ThemeName'] = pref.get(key) ?? "---";
    _prefsMap['LocaleName'] = pref.get(key) ?? "---";
    _prefsMap['RememberMe'] = pref.get(key) ?? false;
    _prefsMap['UseBiometric'] = pref.get(key) ?? false;




    return _prefsMap[key];
  }




// Hello
  //------------------- prefrence theme methods -------------------------

  Future<String> loadThemeNameFromPref () async {
    final pref = await _sprefs;

    var strValue = pref.getString('ThemeName') ?? "themeA";

    return strValue;
  }

  void saveThemeNameToPref({@required String themeName}) async{
    final pref = await _sprefs;
    pref.setString('ThemeName', themeName);
    pref.commit();
  }


  //------------------- prefrence theme methods -------------------------

  Future<String> loadLocaleNameFromPref () async {
    final pref = await _sprefs;

    var strValue = pref.getString('LocaleName') ?? "fa";

    return strValue;
  }

  void saveLocaleNameToPref({@required String localeName}) async{
    final pref = await _sprefs;
    pref.setString('LocaleName', localeName);
    pref.commit();
  }



}