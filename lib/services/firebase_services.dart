import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> createDonor(
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
        'email': email,
        'isOrg': false,
        'donationsCompleted': 0,
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

  Future<void> logDonorIn(String email, String password) async {
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
    return ref['email'];
  }

  // specifc org data edit stuff
  Future<DocumentSnapshot<Map<String, dynamic>>> getSpecifcDonationStuff(
      String id) async {
    return await _db.collection('public').doc(id).get();
  }

  Future<int> getDonationsCompleted() async {
    String uid = _auth.currentUser!.uid;
    final ref = await _db.collection('users').doc(uid).get();
    return ref['donationsCompleted'];
  }

  // // find if the logged in user is donor or org
  // Future<String> whichUserType(String uid) async {
  //   try {
  //     final ref = await _db.collection('users').doc(uid).get();
  //     return 'user';
  //   } catch (e) {
  //     print('acount type org');
  //     final ref = await _db.collection('orgs').doc(uid).get();
  //     return 'org';
  //   }
  // }

  Future<String> whichUserType(String uid) async {
    try {
      final userDoc = await _db.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return 'user';
      }
      final orgDoc = await _db.collection('orgs').doc(uid).get();
      if (orgDoc.exists) {
        return 'org';
      }
      throw Exception('User type not found');
    } catch (e) {
      print('Error determining user type: $e');
      rethrow;
    }
  }

  /// ORG stuff
  Future<void> createOrg(
    String orgName,
    String orgAddy,
    String orgZip,
    String orgPhone,
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var uid = credential.user!.uid; // is a string

      _db.collection('orgs').doc(uid).set({
        'orgName': orgName,
        'address': orgAddy,
        'zipcode': orgZip,
        'phoneNumber': orgPhone,
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

  Future<void> logOrgIn(String email, String password) async {
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

  // get org general info
  Future<String> getOrgInfo(String info) async {
    String uid = _auth.currentUser!.uid;
    final ref = await _db.collection('orgs').doc(uid).get();
    return ref[info];
  }

  // get org name
  Future<String> getOrgName() async {
    String uid = _auth.currentUser!.uid;
    final ref = await _db.collection('orgs').doc(uid).get();
    return ref['orgName'];
  }

  // post org requesting item
  Future<void> postOrgItem(
    String imgPath,
    String itemDesc,
    String quantity,
  ) async {
    int q = int.parse(quantity); // input should always be int

    String uid = _auth.currentUser!.uid;
    _db.collection('orgs').doc(uid).collection('items').add(
      {
        'image_path': imgPath,
        'itemDesc': itemDesc,
        'quantity': q,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );
    String orgName = await getOrgName();

    _db.collection('public').add(
      {
        'orgName': orgName,
        'image_path': imgPath,
        'itemDesc': itemDesc,
        'quantity': q,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );
  }

  // stream the orgs posts
  Stream<List<Map<String, dynamic>>> getOrgItems() {
    String uid = _auth.currentUser!.uid;
    return _db
        .collection('orgs')
        .doc(uid)
        .collection('items')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              Map<String, dynamic> x = doc.data();
              x['id'] = doc.id;
              return x;
            },
          ).toList(),
        );
  }

  // stream the public org posts
  Stream<List<Map<String, dynamic>>> getPublicOrgItem() {
    return _db
        .collection('public')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              Map<String, dynamic> x = doc.data();
              x['id'] = doc.id;
              return x;
            },
          ).toList(),
        );
  }

  // specifc org data edit stuff
  Future<DocumentSnapshot<Map<String, dynamic>>> getSpecifcOrgStuff(
      String id) async {
    String uid = _auth.currentUser!.uid;

    return await _db
        .collection('orgs')
        .doc(uid)
        .collection('items')
        .doc(id)
        .get();
  }

  // update specific desc
  void updateSpecificDesc(String id, String desc) {
    String uid = _auth.currentUser!.uid;

    _db.collection('orgs').doc(uid).collection('items').doc(id).update(
      {
        'itemDesc': desc,
      },
    );
  }

  // update specific quantity
  void updateSpecificQuant(String id, int quantity) {
    String uid = _auth.currentUser!.uid;

    _db.collection('orgs').doc(uid).collection('items').doc(id).update(
      {
        'quantity': quantity,
      },
    );
  }

  // get quantity info
  Future<int> getQuantityPublic(String id) async {
    final ref = await _db.collection('public').doc(id).get();
    return ref['quantity'];
  }

  Future<void> userSentDonationRequest(
    String id,
    int amount,
    String imagePath,
    String orgName,
  ) async {
    String uid = _auth.currentUser!.uid;
    // get prev quantity amount
    int x = await getQuantityPublic(id);
    _db.collection('public').doc(id).update(
      {
        'quantity': x - amount,
      },
    );

    // create a pending in the users now
    _db.collection('users').doc(uid).collection('donations').add({
      'image_path': imagePath,
      'orgName': orgName,
      'size': amount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // stream the donors history
  Stream<List<Map<String, dynamic>>> getDonorHistory() {
    String uid = _auth.currentUser!.uid;
    return _db
        .collection('users')
        .doc(uid)
        .collection('donations')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              Map<String, dynamic> x = doc.data();
              x['id'] = doc.id;
              return x;
            },
          ).toList(),
        );
  }
}
