import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> createUser(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var uid = credential.user!.uid; // is a string

      _db.collection('users').doc(uid).set({
        'username': username,
      });
      _db.collection('users').doc(uid).set({
        'username': email,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errMsg;
      if (e.code == 'invalid-email') {
        errMsg = 'The email address is badly formatted.';
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        errMsg =
            'Double-check that the email and password you are using to sign in are correct.';
      } else {
        errMsg = 'Error: ${e.message}';
      }

      print(errMsg);
    }
  }

  Future<void> signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // get donor username
  Future<String> getDonorUsername() async {
    String uid = _auth.currentUser!.uid;
    final ref = await _db.collection('users').doc(uid).get();
    print(ref);
    return ref['username'];
  }

  // get donor username
  Future<String> getDonorEmail() async {
    String uid = _auth.currentUser!.uid;
    final ref = await _db.collection('users').doc(uid).get();
    print(ref);
    return ref['email'];
  }
}
