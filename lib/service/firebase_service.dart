import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

const String userCollection = 'users';

class FirebaseService {
  FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File photoProfile,
  }) async {
    try {
      log('masuk');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userID = userCredential.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(photoProfile.path);

      UploadTask task =
          _storage.ref("images/$userID/$fileName").putFile(photoProfile);

      return task.then((snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();
        await _db.collection(userCollection).doc(userID).set({
          "name": name,
          "email": email,
          "image": downloadURL,
        });
        return true;
      });
    } catch (e) {
      log('error -> $e');
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        currentUser = await getUserData(uid: userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('error -> $e');
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot documentSnapshot =
        await _db.collection(userCollection).doc(uid).get();

    return documentSnapshot.data() as Map;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
