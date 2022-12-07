import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  GoogleSignInAccount? googleSignInAccount;

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

  static signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );



      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        print(userCredential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
  }
}
