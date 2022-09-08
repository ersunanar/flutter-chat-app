import 'package:ersun_anar_hw3/models/appUsers.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ersun_anar_hw3/routes/sign_in.dart';
import 'package:ersun_anar_hw3/routes/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationStatus extends StatefulWidget {
  const AuthenticationStatus({Key? key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  @override
  _AuthenticationStatusState createState() => _AuthenticationStatusState();
}

class _AuthenticationStatusState extends State<AuthenticationStatus> {
  @override
  Widget build(BuildContext context) {

    print('Authentication build function called');
    final user = Provider.of<User?>(context);

    if(user == null) {
      return SignIn();
    }
    else {

      return HomePage(analytics: widget.analytics, observer: widget.observer);
    }
  }
}

