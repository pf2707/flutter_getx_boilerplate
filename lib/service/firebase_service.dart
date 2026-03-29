
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_getx_boilerplate/model/user.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';

enum AuthError {
  registerErrorWeakPassword,
  registerErrorEmailInUsed,
  signInUserNotFound,
  signInEmailAlreadyInUsed
}

class FirebaseService {
  static var instance = FirebaseService();

  String? get ownerFirebaseUid {
    return FirebaseAuth.instance.currentUser?.uid;
  }
}

extension FirebaseServiceUser on FirebaseService {

  Future<UserCredential?> registerNewAccount({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugLog('The password provided is too weak.');
        throw AuthError.registerErrorWeakPassword;
      } else if (e.code == 'email-already-in-use') {
        debugLog('The account already exists for that email.');
        throw AuthError.registerErrorEmailInUsed;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserCredential?> logIn({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugLog('No user found for that email.');
        throw AuthError.signInUserNotFound;
      } else if (e.code == 'invalid-credential') {
        debugLog('Wrong password provided for that user.');
        throw AuthError.signInEmailAlreadyInUsed;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugLog('No user found for that email.');
        throw AuthError.signInUserNotFound;
      } else if (e.code == 'wrong-password') {
        debugLog('Wrong password provided for that user.');
        throw AuthError.signInEmailAlreadyInUsed;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  createNewUser(String refId, UserObj user) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection("users").doc(refId).set(user.toJson());
    } catch (e) {
      debugLog("create new user error = $e");
    }
  }

  updateUser(String refId, UserObj user) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection("users").doc(refId).update(user.toJson());
    } catch (e) {
      debugLog("update user error = $e");
    }
  }

  Future<UserObj?> userHasFirebaseUid(String uid) async {
    var db = FirebaseFirestore.instance;
    try {
      var doc = await db.collection("users").doc(uid).get();
      return UserObj.fromJson(doc.data());
    } catch (e) {
      debugLog("can not get user from firebase - error = ${e.toString()}");
    }
    return null;
  }
}