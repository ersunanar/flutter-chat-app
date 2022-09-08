import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Crashlytics {
  final FirebaseCrashlytics _instance = FirebaseCrashlytics.instance;

  void crashApp() {
    _instance.crash();
  }

  void toggleStatus(bool status) {
    _instance.setCrashlyticsCollectionEnabled(status);
  }

  bool isCollecting() {
    return _instance.isCrashlyticsCollectionEnabled;
  }

  Future<void> customLog(String log) async {
    await _instance.log(log);
  }

  Future<void> setUser(String userID) async {
    await _instance.setUserIdentifier(userID);
  }
}