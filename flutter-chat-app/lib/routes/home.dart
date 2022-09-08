

import 'package:ersun_anar_hw3/routes/chat.dart';
import 'package:ersun_anar_hw3/routes/register.dart';
import 'package:ersun_anar_hw3/routes/sign_in.dart';
import 'package:ersun_anar_hw3/util/styles.dart';
import 'package:ersun_anar_hw3/widgets/message_box_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ersun_anar_hw3/models/appUsers.dart';
import 'package:ersun_anar_hw3/routes/post_list.dart';
import 'package:ersun_anar_hw3/routes/user_profile.dart';
import 'package:ersun_anar_hw3/services/auth.dart';
import 'package:ersun_anar_hw3/services/database.dart';
import 'package:ersun_anar_hw3/util/analytics.dart';
import 'package:ersun_anar_hw3/util/crashlytics.dart';
import 'package:provider/provider.dart';

import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var crashlytics = Crashlytics();
  var _auth = AuthService();
  String message = '';

  var _pageViewController = PageController(initialPage: 0);




  void setMessage(String input) {
    setState(() {
      message = input;
    });
  }

  Future<bool> _willPop() async {
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //setCurrentScreen(widget.analytics, widget.observer, 'Home Page', 'HomePageState');    // null olmadığından eminseniz ! işaretini kullanın. yoksa ?? FireBase() kullanılması tercih edilir.
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    final db = DBService(uid: user!.uid);
    final appUser = db.appUserData;
if (!user.isAnonymous) {
  return StreamProvider<List<AppUser>>.value(        //Stream: 9.video 1:42
    value: db.userList,
    initialData: [],
    child: WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            title: Text('${user.isAnonymous ? 'anonymous user':user.email! } '),
            centerTitle: false,
            backgroundColor: Colors.brown[400],
            actions: [
              TextButton.icon(
                icon: Icon(Icons.person, color: Colors.white),
                label: Text('Logout', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _auth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(analytics: widget.analytics, observer: widget.observer)));

                },
              ),
              SizedBox(width: 16,),
              TextButton.icon(
                icon: Icon(Icons.settings, color: Colors.white),
                label: Text('', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (user.isAnonymous) {
                    showAlertDialog();

                  }
                  else {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => UserProfile(analytics: widget.analytics, observer: widget.observer)),
                    );
                  }

                },
              ),
            ],
          ),
          body: PageView(
            controller: _pageViewController,
            children: [

              Padding(

                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(

                      'Welcome your homepage....',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50,),

                    Row(
                      children: [
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Text(

                          'swipe the screen to chat ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),




              UserListView(analytics: widget.analytics, observer: widget.observer)
//user.isAnonymous ? UserListView(analytics: widget.analytics, observer: widget.observer): Text('you must register to chat')
            ],
          )
      ),
    ),
  );

} else {

  return Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            title: Text('${user.isAnonymous ? 'anonymous user':user.email! } '),
            centerTitle: false,
            backgroundColor: Colors.brown[400],
            actions: [
              TextButton.icon(
                icon: Icon(Icons.person, color: Colors.white),
                label: Text('Logout', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _auth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(analytics: widget.analytics, observer: widget.observer)));

                },
              ),
              SizedBox(width: 16,),
              TextButton.icon(
                icon: Icon(Icons.settings, color: Colors.white),
                label: Text('', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (user.isAnonymous) {
                    showAlertDialog();

                  }
                  else {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => UserProfile(analytics: widget.analytics, observer: widget.observer)),
                    );
                  }

                },
              ),
            ],
          ),
          body: PageView(
            controller: _pageViewController,
            children: [

              Padding(

                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(

                      'Welcome your homepage....',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    SizedBox(height: 50,),

                    Row(
                      children: [
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Icon(Icons.arrow_left, size: 20, color: Colors.green,),
                        Text(

                          'swipe the screen to chat ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),




              Padding(

                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(

                      'You must register to chat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Register(analytics: widget.analytics, observer: widget.observer)));
                            },

                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Register',
                                style: kButtonDarkTextStyle,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
//user.isAnonymous ? UserListView(analytics: widget.analytics, observer: widget.observer): Text('you must register to chat')
            ],
          )
      );


}


  }







  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(4),
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      elevation: 4,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8),
    );
  }




  Future<void> showAlertDialog() async {

    bool isIOS = Platform.isIOS;
    //bool isIOS = true;

    return showDialog<void> (
        context: context,
        barrierDismissible: false,      // herhangi bir yere basarak pop up'ı kapatma imkanı kaldırılıyor
        builder: (BuildContext context) {

          return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              titlePadding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              title: Row(
                children: [
                  Text('....'),

                  Spacer(),     // iki şeyi birbirinden uzaklaştırmak için

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close, color: Colors.red),
                  )
                ],
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text('Register'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('you are anonymous user. If you want to update profile you must first register...'),
                  ],
                ),
              ),
            );


        }
    );
  }



















}
