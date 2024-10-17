// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreenController with ChangeNotifier {
  bool isLoading = false;
  onLogin(
      {required String emailAddress,
      required String password,
      required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user != null) {
        SnackBar(content: Text("User login successful!"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBar(content: Text("No user found for that email."));
      } else if (e.code == 'wrong-password') {
        SnackBar(content: Text("Wrong password provided for that user."));
      }
    }
    isLoading =false;
    notifyListeners();
  }
}
