import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ersun_anar_hw3/models/appUsers.dart';

import 'auth.dart';

class DBService {
  final String uid;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference chatCollection = FirebaseFirestore.instance.collection('chats');

  DBService({required this.uid});


  Future<void> createAppUserData(AppUser user) async {
    return userCollection.doc(uid).set({
      'userID': uid,
      'name': user.name,
      'surname': user.surname,
      'username' : user.username,
      'strength': user.strength,
    });
  }


  Future<void> saveMessage(AppUser user) async {
    return userCollection.doc(uid).set({
      'name': user.name,
      'surname': user.surname,
      'username' : user.username,
      'strength': user.strength,
    });
  }


/*
  List<AppUser> _userListFromDB(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppUser(userID: doc.get('userID'), name: doc.get('name'), surname: doc.get('surname'), username: doc.get('username'),  strength: doc.get('strength'));
    }).toList();
  }
*/

 Stream<List<AppUser>> get userList {

    return userCollection.snapshots()
        .map((event) => event
        .docs
        .map((e) => AppUser(userID: e.get('userID'), name: e.get('name'), surname: e.get('surname'), username: e.get('username'), strength: e.get('strength')))
        .where((element) => element.userID != uid)
        .toList());
  }

  /*
  Stream<List<AppUser>> get userList {
    return userCollection.snapshots().map(_userListFromDB);
  }

   */

  AppUser _appUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return AppUser(
        userID: snapshot.get('userID'),
        name: snapshot.get('name'),
        surname : snapshot.get('surname'),
        username: snapshot.get('username'),
        strength: snapshot.get('strength'),
    );
  }



  // get user doc stream

    Stream<AppUser> get appUserData {
    return userCollection.doc(uid).snapshots()
        .map(_appUserDataFromSnapshot);
  }



}

