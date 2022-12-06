import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<String> registerUser(String userEmail, String userPass) async {
    String response = '';
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );

      response = 'Account created';
    } on SocketException catch (e) {
      response = 'Check Internet';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        response = 'The account already exists for that email.';
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  static bool checkLoggedUser() {
    bool loggedUser = false;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        loggedUser = false;
      } else {
        loggedUser = true;
      }
    });

    return loggedUser;
  }

  static Future<String> signInUser(String email, String password) async {
    String response = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      response = 'ok';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //  print('No user found for that email.');
        response = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        response = 'Wrong password provided for that user.';
      }
    }
    return response;
  }
}
