

/*
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ersun_anar_hw3/widgets/message_box_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ersun_anar_hw3/models/appUsers.dart';
import 'package:ersun_anar_hw3/routes/post_list.dart';
//import 'package:ersun_anar_hw3/routes/user_profile.dart';
import 'package:ersun_anar_hw3/services/auth.dart';
import 'package:ersun_anar_hw3/services/database.dart';
import 'package:ersun_anar_hw3/util/analytics.dart';
import 'package:ersun_anar_hw3/util/crashlytics.dart';
import 'package:provider/provider.dart';
import 'dart:math';


class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  //final FirebaseAnalytics? analytics;
  //final FirebaseAnalyticsObserver? observer;
//, this.analytics, this.observer

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String user1;
  late String groupChatId;
  late String user2;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getGroupChatId();
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final db = DBService(uid: user!.uid);



    return Scaffold(
      appBar: AppBar(
        title: Text('Chat page!'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats')
            .doc(groupChatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (listContext, index) =>
                          buildItem(snapshot.data.doc[index]),
                      itemCount: snapshot.data.documents.length,
                      reverse: true,
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: (){

                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ));
          }
        },
      ),
    );
  }



  sendMsg() {
    String msg = textEditingController.text.trim();

    /// Upload images to firebase and returns a URL

    if (msg.isNotEmpty) {
      print('thisiscalled $msg');
      var ref = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(ref, {
          "senderId": userID,
          "anotherUserId": widget.docs['id'],
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          "type": 'text',
        });
      });

      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
    } else {
      print('Please enter some text to send');
    }
  }

  buildItem(doc) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8.0,
          left: ((doc['senderId'] == ) ? 64 : 0),
          right: ((doc['senderId'] == userID) ? 0 : 64)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: ((doc['senderId'] == userID)
                ? Colors.grey
                : Colors.greenAccent),
            borderRadius: BorderRadius.circular(8.0)),
        child: (doc['tyoe'] == 'text')
            ? Text('${doc['content']}')
            : Image.network(doc['content']),
      ),
    );
  }


  getGroupChatId(String user1, String user2) async {
    if (user1.compareTo(user2) > 0) {
      groupChatId = user1+user2;
    } else {
      groupChatId = user2+user1;
    }
    setState(() {});
  }



}




*/


