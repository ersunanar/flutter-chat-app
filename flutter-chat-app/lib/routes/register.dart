import 'dart:math';

import 'package:ersun_anar_hw3/models/appUsers.dart';
import 'package:ersun_anar_hw3/routes/home.dart';
import 'package:ersun_anar_hw3/services/auth.dart';
import 'package:ersun_anar_hw3/services/database.dart';
import 'package:ersun_anar_hw3/util/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key,  this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();


  String? name;
  String? surname;
  String? username;
  String? mail;
  String? pass;
  String? pass2;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Registration Page'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
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
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Name',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.name,

                          validator: (String? value) {
                            if(value == null) {
                              return 'Please enter your name';
                            }
                            else {
                              if(value.isEmpty) {
                                return 'Please enter your name';
                              }

                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            name = value;
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
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Surname',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (String? value) {
                            if(value == null) {
                              return 'Please enter your surname';
                            }
                            else {
                              if(value.isEmpty) {
                                return 'Please enter your surname';
                              }

                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            surname = value;
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
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Username',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.name,

                          validator: (String? value) {
                            if(value == null) {
                              return 'Please enter an username';
                            }
                            else {
                              if(value.isEmpty) {
                                return 'Please enter an username';
                              }

                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            username = value;
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
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'E-mail',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (String? value) {
                            if(value == null) {
                              return 'ERROR';
                            }
                            else {
                              if(value.isEmpty) {
                                return 'Please enter your e-mail';
                              }
                              if(!EmailValidator.validate(value)) {
                                return 'The e-mail address is not valid';
                              }
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            mail = value;
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
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (String? value) {
                            pass = value;
                            if(value == null) {
                              return 'ERROR';
                            }
                            else {
                              if(value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if(value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              if(value.toString() != pass2.toString()) {
                                return 'Passwords don\'t match';
                              }
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value;
                          },
                        ),
                      ),

                      SizedBox(width: 4.0),

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password (repeat)',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            pass2 = value;

                            if(value == null) {
                              return 'ERROR';
                            }
                            else {
                              if(value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if(value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              if(value.toString() != pass.toString()) {
                                return 'Passwords don\'t match';
                              }
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.0),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () async {

                            if(_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              dynamic result = await _auth.signUpWithEmailAndPass(mail!, pass!);

                              if(result == null) {
                                print('Registration failed');
                              }
                              else {
                                print('User registered');

                                final db = DBService(uid: result.uid);
                                int strength = Random().nextInt(7) * 100 + 100;
                                AppUser appUser = AppUser(userID: result.uid , name: name!, surname: surname!, username: username!, strength: strength);
                                db.createAppUserData(appUser);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(analytics: widget.analytics, observer: widget.observer)));



                              }

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Registered')));

                            }

                              //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));


                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
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

            
          ],
        ),
      ),
    );
  }
}
