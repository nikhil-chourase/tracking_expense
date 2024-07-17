
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracking_expense/constants/constants.dart';
import 'package:tracking_expense/data/model/user/user.dart' as model;

class AuthService with ChangeNotifier {
 
  User? _user;

  AuthService() {
    firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  User? get user => _user;


  bool isUserLoggedIn() {
    return _user != null;
  }

  

  Future<bool> registerUser(String username, String email, String password) async {
    try {
     

      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      model.User user = model.User(
        name: username,
        email: email,
        uid: cred.user!.uid,
      );

      await firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson());


      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
      } else {
        print('Error during registration: ${e.message}');
      }
      return false;
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
     

      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );



    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
      } else {
        print('Error during login: ${e.message}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print('Error during sign out: $e');
    }
  }
  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }
}