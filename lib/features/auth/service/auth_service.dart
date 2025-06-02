import 'dart:developer';

import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/features/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> signUpWithEmailAndPassword(String name, String email, String password, String uuid) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        final userId = uuid;
        final userData = {
          'id': userId,
          'firebaseUid': user.uid,
          'name': name,
          'profileImage': null,
          'email': email,
          'phone': '',
        };

        await FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
        await processLogin(user);
      }
    } on FirebaseAuthException catch (e) {
      log('firebase exception : ${e.message}');
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        await processLogin(user);
      }
    } on FirebaseAuthException catch (e) {
      log('firebase exception : ${e.message}');
      rethrow;
    }
  }

  Future<void> processLogin(User user) async {
    final authUid = user.uid;

    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').where('firebaseUid', isEqualTo: authUid).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data();
      UserModel userDataLocal = UserModel();
      LocalData().cleanUp();
      userDataLocal = UserModel.fromJson(userData);
      LocalData().localUserData = userDataLocal;
      LocalData().userId = userDataLocal.id;
      LocalData().userName = userDataLocal.name ?? 'User';
      LocalData().email = userDataLocal.email;
    }
  }
}
