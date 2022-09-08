

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ersun_anar_hw3/models/appUsers.dart';
import 'package:ersun_anar_hw3/routes/home.dart';

import 'package:ersun_anar_hw3/services/auth.dart';
import 'package:ersun_anar_hw3/services/database.dart';
import 'package:ersun_anar_hw3/util/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  const UserProfile({Key? key,  this.analytics, this.observer }) : super(key: key);



  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  String? new_name;
  String? new_surname;
  String? new_username;
  String? new_strength;
  final _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
   final user = Provider.of<User?>(context);
   //final app_user = Provider.of<AppUser?>(context);
   final db = DBService(uid: user!.uid);

    return  StreamBuilder<AppUser>(
      stream: db.appUserData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser app_user = snapshot.data!;
          print(app_user.name);
          TextEditingController _name = TextEditingController(text: app_user.name);
          TextEditingController _surname = TextEditingController(text: app_user.surname);
          TextEditingController _username = TextEditingController(text: app_user.username);
          TextEditingController _strength = TextEditingController(text: app_user.strength.toString());

          return Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text(app_user.username),
            ),

            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [


                  Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _name,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,

                                    hintText: 'new name for updating',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),

                                  keyboardType: TextInputType.name,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the new value for your name';
                                    }
                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the new value for your name';
                                      }

                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_name = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _surname,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'new surname for updating',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),

                                  keyboardType: TextInputType.emailAddress,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the new value for your surname';
                                    }
                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the new value for your surname';
                                      }

                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_surname = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _username,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'new username for updating',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the new value for the username';
                                    }
                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the new value for the username';
                                      }

                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_username = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _strength,

                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'new color strength (number)',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the color strength';
                                    }

                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the color strength';
                                      }

                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_strength = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () async {

                                    if(_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();


                                      AppUser appUser = AppUser(userID: user.uid, name: new_name!, surname: new_surname!, username: new_username!, strength: int.parse(new_strength!));
                                      db.createAppUserData(appUser);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('Updated')));
                                    }

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(analytics: widget.analytics, observer: widget.observer)));

                                  },

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      'Update Profile',
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

                ],
              ),
            ),
          );
        }
        else {


        return Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('User Profile'),
              ),

              body: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                 // initialValue: appUser.name,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,

                                    hintText: 'new name for updating',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),

                                  keyboardType: TextInputType.name,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the new value for your name';
                                    }
                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the new value for your name';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_name = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                 // initialValue: appUser.surname,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'new surname for updating',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),

                                  keyboardType: TextInputType.emailAddress,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the new value for your surname';
                                    }
                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the new value for your surname';
                                      }

                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_surname = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  //initialValue: appUser.username,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'new username for updating',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the new value for the username';
                                    }
                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the new value for the username';
                                      }

                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_username = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  //initialValue: app_user.strength.toString(),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'new color strength (number)',
                                    //labelText: 'Username',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,

                                  validator: (String? val) {
                                    if(val == null) {
                                      return 'Please enter the color strength';
                                    }

                                    else {
                                      if(val.isEmpty) {
                                        return 'Please enter the color strength';
                                      }

                                    }

                                    return null;
                                  },
                                  onSaved: (String? val) {
                                    new_strength = val;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.0,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () async {

                                    if(_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();


                                     AppUser appUser = AppUser(userID: user.uid, name: new_name!, surname: new_surname!, username: new_username!, strength: int.parse(new_strength!));
                                     db.createAppUserData(appUser);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('Updated')));
                                    }

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(analytics: widget.analytics, observer: widget.observer)));

                                  },

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Update Profile',
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
                  ],
                ),
              ),
            );
        }
      }
    );
      }
  }
