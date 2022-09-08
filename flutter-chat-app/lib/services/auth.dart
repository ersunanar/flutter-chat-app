import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService() {}


  User? _userFromFirebase(User? user) {
    return user;
  }


  //Auth Stream
  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future singInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPass(String mail, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User? user = result.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      if(e.code == 'user-disabled') {
        print('Your account is disabled');
        return null;
      }
      if(e.code == 'user-not-found') {
        print('Please check your e-mail and try again');
        return null;
      }
      if(e.code == 'wrong-password') {
        print('Wrong password');
        return null;
      }
      return null;
    } catch(e) {
      print('Unknown error: ${e.toString()}');
      return null;
    }
  }

  Future signUpWithEmailAndPass(String mail, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      User? user = result.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      if(e.code == 'email-already-in-use') {
        return 'This email is already registered';
      }
      if(e.code == 'operation-not-allowed') {
        return 'This operations is disabled';
      }
      if(e.code == 'weak-password') {
        return 'Password is not secure enough';
      }
      return null;
    } catch(e) {
      return 'Unknown error: ${e.toString()}';
    }
  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}