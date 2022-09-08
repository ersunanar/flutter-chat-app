import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:ersun_anar_hw3/models/appUsers.dart';

import 'chat.dart';


class UserTile extends StatelessWidget {

  final AppUser user;

  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(user.userID)));

        print(user.userID);

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
                backgroundColor: Colors.brown[user.strength],
              ),
            ),
            SizedBox(width: 16,),
            Text(user.name + ' ' + user.surname)
          ],
        ),
      ),
    );
  }
}




