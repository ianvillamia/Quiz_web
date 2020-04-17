import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedData {
  Future<int> _getReloadCounter() async {
    //getting startupnumber
    final pref = await SharedPreferences.getInstance();
    final startupNumber = pref.get('startupNumber');
    if (startupNumber == null) {
    
      await pref.setBool('isLoggedIn', false);
      return 0;
    }
    return startupNumber;
  }

  Future<void> startUp() async {
    final pref = await SharedPreferences.getInstance();
    int lastStartupNumber = await _getReloadCounter();
    int currentStartupNumber = ++lastStartupNumber;
    await pref.setInt('startupNumber', currentStartupNumber);
    print(currentStartupNumber.toString());
 
  }

  Future getSharedPrefData({@required String key}) async {
    final pref = await SharedPreferences.getInstance();
    final sharedData = pref.get(key);
    if (sharedData == null) {
      return null;
    }
    return sharedData;
  }

  Future resetSharedPrefData({@required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
}
