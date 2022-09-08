
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ersun_anar_hw3/models/message.dart';
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
import 'dart:math';


class ChatPage extends StatefulWidget {


  ChatPage({Key? key}) : super(key: key);
  //final FirebaseAnalytics? analytics;
  //final FirebaseAnalyticsObserver? observer;
//, this.analytics, this.observer

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  late String groupChatID;
  late String signedInUser;



  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatUser = ModalRoute.of(context)!.settings.arguments as AppUser;
    final user = Provider.of<User?>(context);
    final db = DBService(uid: user!.uid);
    getGroupChatId(user.uid,chatUser.userID);
    print(user.uid);
    signedInUser = user.uid;
    print(DateTime.now().millisecondsSinceEpoch.toString());

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Chat page')),
        backgroundColor: Colors.brown[400],
      ),
      body: StreamBuilder<List<TextMessage>>(
        stream: FirebaseFirestore.instance.collection('chats')
            .doc(groupChatID)
            .collection('messages')
            .orderBy('timestamp')
            .snapshots()
            .map((event) => event
            .docs.map((e) => TextMessage(senderID: e.get('senderID'), timestamp: e.get('timestamp'), message: e.get('message')))
            .toList()),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            
            return Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                      itemCount:snapshot.data!.length,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onLongPressUp: () {


                            if (snapshot.data![index].senderID == signedInUser) {
                              showAlertDialog(snapshot.data![index].timestamp);
                            }


                          },

                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8.0,
                                left: ((snapshot.data![index].senderID == signedInUser ) ? 100 : 0),
                                right: ((snapshot.data![index].senderID == signedInUser) ? 0 : 100)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: ((snapshot.data![index].senderID == signedInUser)
                                      ? Colors.orange[200]
                                      : Colors.blue[200]),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text('${snapshot.data![index].message.isEmpty ? 'deleted message' : snapshot.data![index].message}',
                              style: TextStyle (
                                color: snapshot.data![index].message.isNotEmpty ? Colors.black  : Colors.grey,
                                fontStyle: snapshot.data![index].message.isNotEmpty ? FontStyle.normal : FontStyle.italic,


                              ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                ),
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
                        sendMsg();
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



  Future<void> sendMsg()  async {
    String msg = textEditingController.text.trim();
    textEditingController.clear();

    if (msg.isNotEmpty) {

      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      print(timeStamp);
      return FirebaseFirestore.instance
          .collection('chats')
          .doc(groupChatID)
          .collection('messages')
          .doc(timeStamp).set({
        'senderID': signedInUser,
        'timestamp': timeStamp,
        'message': msg,
      });
      ;
    } else {
      print('Please enter some text to send');
    }
  }



  Future<void> deleteMessage(String timestampID)  async {

      return FirebaseFirestore.instance
          .collection('chats')
          .doc(groupChatID)
          .collection('messages')
          .doc(timestampID).update({
        'message': '',
      });

    }


  getGroupChatId(String user1, String user2) async {
    if (user1.compareTo(user2) > 0) {
      groupChatID = user1+user2;
    } else {
      groupChatID = user2+user1;
    }
    setState(() {});
    print(groupChatID);
  }




  Future<void> showAlertDialog(String timestampID) async {

    return showDialog<void> (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            titlePadding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            title: Row(
              children: [
                Text('deleting message'),

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

                  Navigator.of(context).pop();
                  deleteMessage(timestampID);
                },
                child: Text('Delete'),
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
                  Text('Are you sure to delete this message'),
                ],
              ),
            ),
          );


        }
    );
  }


}







