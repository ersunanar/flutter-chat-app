import 'package:ersun_anar_hw3/routes/authStatus.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ersun_anar_hw3/services/auth.dart';
import 'package:provider/provider.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Wrapper());
}

class Wrapper extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError) {
          print('Cannot connect to firebase: '+snapshot.error.toString());
          return MaterialApp(home: NoFirebaseView());
        }
        if(snapshot.connectionState == ConnectionState.done) {
          print('Firebase connected');
          return MyApp();
        }

        return MaterialApp(home: LoadingView());
      },
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        navigatorObservers: [observer],
        home: AuthenticationStatus(analytics: analytics, observer: observer,),
      ),
    );
  }
}



class NoFirebaseView extends StatelessWidget {
  const NoFirebaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
                'Cannot connect to server',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold)
            )
        )
    );
  }
}


class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
                'Waiting for server',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)
            )
        )
    );
  }
}

