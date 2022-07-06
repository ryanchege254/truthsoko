// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:truthsoko/Utils/Auth/AuthErrors.dart';

import '../../src/Widget/constants.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  final FirebaseAuth _auth;
  User? _user;
  final GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _signInAccount;
  Status _status = Status.Uninitialized;

  UserRepository.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  User? get user => _user;
  String getCurrentUID() {
    return _auth.currentUser!.uid;
  }

  getProfileImage() {
    if (_auth.currentUser!.photoURL != null) {
      return Image.network(_auth.currentUser?.photoURL ?? "",
          height: 50, width: 50);
    } else {
      return const Icon(Icons.account_circle, size: 50);
    }
  }

  Future<bool> signIn(
      BuildContext _context, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      showMessage(_context, catchErrors(e.code));
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(
      BuildContext _context, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await user!.sendEmailVerification();
      });

      if (user!.emailVerified) {
        return true;
      }
      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      showMessage(_context, catchErrors(e.code));
      notifyListeners();
      return false;
    }
  }

  Future signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      _signInAccount = googleUser;
    }
    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    _status = Status.Authenticated;
    notifyListeners();
  }

  Future signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future resetPassword(BuildContext _context, String _forgotPassword) async {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => const Center(
          child: Padding(
        padding: EdgeInsets.all(64.0),
        child: LoadingIndicator(
          indicatorType: Indicator.ballZigZag,
          colors: [Global.orange, Global.green, Global.yellow],
        ),
      )),
    );
    try {
      if (user!.emailVerified) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _forgotPassword)
            .then(
                (value) => showMessage(_context, "Password Reset Email Sent"));

        Navigator.of(_context).popUntil((route) => route.isFirst);
      } else {
        showMessage(_context,
            "Check your email for verification! Ensure your email is verified");
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showMessage(_context, e.message.toString());
      Navigator.of(_context).pop();
      notifyListeners();
    }
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    // ignore: unnecessary_null_comparison
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  void showMessage(BuildContext _context, String message) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }
}
