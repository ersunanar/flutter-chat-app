import 'package:ersun_anar_hw3/services/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ersun_anar_hw3/routes/user_tile.dart';
import 'package:provider/provider.dart';
import 'package:ersun_anar_hw3/models/appUsers.dart';

import 'chat.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key, this.analytics, this.observer}) : super(key: key);
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    print(_auth.user);
    print(_auth);

    final userList = Provider.of<List<AppUser>>(context);
    //userList.reversed;

  return Column(
    children: [
      Center(
        child: Text(
          'Friends',
          style: TextStyle(
              color: Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.bold

          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(),
                      settings: RouteSettings(
                          arguments: userList[index]
                      )));

                  print(userList[index].userID);
                  //print(signedInUser.uid);

                },
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.brown[userList[index].strength],
                        ),
                      ),
                      SizedBox(width: 16,),
                      Text(userList[index].name + ' ' + userList[index].surname)
                    ],
                  ),
                ),
              );

            }






        ),
      ),


    ],
  );


  }
}
