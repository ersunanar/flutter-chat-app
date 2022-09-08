import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

Future<void> setCurrentScreen(FirebaseAnalytics analytics, FirebaseAnalyticsObserver observer, String screenName, String className) async {
  await analytics.setCurrentScreen(
    screenName: screenName,
    screenClassOverride: className,
  );
  print('$screenName logged');
}

Future<void> setUserId(FirebaseAnalytics analytics, FirebaseAnalyticsObserver observer, String userID) async {
  await analytics.setUserId(userID);
  print('$userID log successful');
}

Future<void> logCustomEvent(FirebaseAnalytics analytics, FirebaseAnalyticsObserver observer, String logName, Map<String, dynamic> map) async {
  await analytics.logEvent(
    name: logName,
    parameters: map,
  );
}