
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/constant/constant.dart';
import 'package:flutter_getx_boilerplate/main.dart';
import 'package:flutter_getx_boilerplate/model/api/error_response.dart';
import 'package:flutter_getx_boilerplate/service/firebase_service.dart';
import 'package:flutter_getx_boilerplate/model/user.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';
import 'package:get/get.dart';

class DataManager {
  static final shared = DataManager();

  var users = <String, FirebaseUser>{}; //key: firebase refId of user

  prepare() async {
    // await FirebaseAuth.instance.signOut();
  }
}

extension DataManagerAccount on DataManager {
  bool get isLogin {
    return FirebaseAuth.instance.currentUser != null;
  }

  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (context.mounted) {
      AppBuilder.restart(Get.context!);
    }
  }

  entrance(FirebaseUser user) async {
    var existedUser = await userHasFirebaseUid(user.firebaseRefId);
    if (existedUser == null) {
      //Create new user
      await FirebaseService.instance.createNewUser(user.firebaseRefId, user.user);
    }
  }

  Future<String?> signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      final idToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
      debugLog("Signed in with temporary account: ${userCredential.user?.uid} - idToken = $idToken");
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          debugLog("Anonymous auth hasn't been enabled for this project.");
          throw LoginErrorResponse(
            error: EnumLoginError.firebaseOperationNotAllow,
            message: "error_login_common".tr,
          );
        default:
          debugLog("Unknown error: ${e.message}");
          throw LoginErrorResponse(
            error: EnumLoginError.unknown,
            message: "error_login_common".tr,
          );
      }
    }
  }

  Future<String?> linkAccountWithGoogleSignIn({String? idToken, String? accessToken}) async {
    try {
      // 1. Check if user is currently anonymous (optional but good to show UI message)
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        debugLog("Link account google: No active session. Please sign in anonymously first.");
        throw LoginErrorResponse(
          error: EnumLoginError.anonymousSessionNotFound,
          message: "error_login_common".tr,
        );
      }

      if (!currentUser.isAnonymous) {
        debugLog("Link account google: Account is already linked or permanent");
        throw LoginErrorResponse(
          error: EnumLoginError.accountIsLinked,
          message: "error_link_account_already_linked".tr,
        );
      }
      final credential = GoogleAuthProvider.credential(idToken: idToken, accessToken: accessToken);
      final userCredential = await currentUser.linkWithCredential(credential);
      debugLog("Link account with google: ${userCredential.user?.uid}");
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'provider-already-linked':
          debugLog("Link account google: Google provider is already linked to this account.");
          throw LoginErrorResponse(
            error: EnumLoginError.providerIsAlreadyLinkedToThisAccount,
            message: "error_link_account_google_linked_to_this_account".tr,
          );
        case 'credential-already-in-use':
          debugLog("Link account google: This Google account is already linked to another user.");
          throw LoginErrorResponse(
            error: EnumLoginError.credentialIsLinkedToAnotherAccount,
            message: "error_link_account_google_linked_to_another_account".tr,
          );
        case 'operation-not-allowed':
          debugLog("Link account google: Google sign-in is not enabled in Firebase console");
          throw LoginErrorResponse(
            error: EnumLoginError.firebaseOperationNotAllow,
            message: "error_login_common".tr,
          );
        case 'invalid-credential':
          debugLog("Link account google: Invalid Google credential.");
          throw LoginErrorResponse(
            error: EnumLoginError.invalidCredential,
            message: "error_login_common".tr,
          );
        default:
          debugLog("Link account google: ${e.toString()}");
          throw LoginErrorResponse(
            error: EnumLoginError.unknown,
            message: "error_login_common".tr,
          );
      }
    }
  }

  Future<String?> unlinkSocialGoogleAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugLog("unlink google account: No user signed in");
      throw LoginErrorResponse(
        error: EnumLoginError.noAuthorizedUserFound,
        message: "error_login_common".tr,
      );
    }

    // Optional: Prevent unlinking if it's the last provider
    if (user.providerData.length <= 1) {
      debugLog("unlink google account: Cannot unlink the last sign-in method");
      throw LoginErrorResponse(
        error: EnumLoginError.noAuthorizedUserFound,
        message: "error_unlink_account_prevent_unlink_last_provider".tr,
      );
    }

    try {
      const providerId = "google.com";
      await user.unlink(providerId);

      // Optional: Force refresh user data
      await user.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;
      debugLog('Remaining providers: ${updatedUser?.providerData.map((p) => p.providerId).toList()}');
      return updatedUser?.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'no-such-provider':
          debugLog("unlink google account: The account is not linked to this provider.");
          throw LoginErrorResponse(
            error: EnumLoginError.noAuthorizedUserFound,
            message: "error_unlink_account_no_such_provider".tr,
          );
        case 'requires-recent-login':
          debugLog("unlink google account: Please re-authenticate to perform this action.");
          // → You may need to reauthenticate the user first (e.g., prompt Google sign-in again)
          throw LoginErrorResponse(
            error: EnumLoginError.requiredReAuthenticate,
            message: "Please re-authenticate to perform this action",
          );
        default:
          debugLog("unlink google account: ${e.toString()}");
          throw LoginErrorResponse(
            error: EnumLoginError.unknown,
            message: "error_login_common".tr,
          );
      }
    } catch (e) {
      debugLog("unlink google account 1: ${e.toString()}");
      throw LoginErrorResponse(
        error: EnumLoginError.unknown,
        message: "error_login_common".tr,
      );
    }
  }

  Future<bool> deleteAccount() async {
    try {
      var ownerRefId = ownerFirebaseUid;
      if (ownerRefId != null) {
        await FirebaseAuth.instance.currentUser?.delete();

        return true;
      }
    } on FirebaseAuthException catch (e) {
      debugLog("can not delete account - error = $e");
      //requires-recent-login
      if (e.code == 'requires-recent-login') {

      }
    }

    return false;
  }

  Future<FirebaseUser?> userHasFirebaseUid(String uid, {bool forceRefresh = false}) async {
    var existedUser = users[uid];
    if (existedUser != null && !forceRefresh) {
      return existedUser;
    }
    try {
      var user = await FirebaseService.instance.userHasFirebaseUid(uid);
      if (user != null) {
        var firebaseUser = FirebaseUser(firebaseRefId: uid, user: user);
        users[uid] = firebaseUser;

        return firebaseUser;
      }
    } catch (e) {
      debugLog("can not get user - error = $e");
    }

    return null;
  }

  createNewUser(String refId, UserObj user) async {
    try {
      await FirebaseService.instance.createNewUser(refId, user);
    } catch (e) {
      debugLog("create new user error = $e");
    }
  }

  updateUser(String refId, UserObj user) async {
    try {
      await FirebaseService.instance.updateUser(refId, user);
    } catch (e) {
      debugLog("update user error = $e");
    }
  }

  updateOwner(UserObj user) async {
    try {
      final ownerRefId = ownerFirebaseUid;
      if (ownerRefId != null) {
        await FirebaseService.instance.updateUser(ownerRefId, user);
        await ownerProfile(forceRefresh: true);
      }
    } catch (e) {
      debugLog("update user error = $e");
    }
  }

  String? get ownerFirebaseUid {
    return FirebaseService.instance.ownerFirebaseUid;
  }

  FirebaseUser? cachedOwnerProfile() {
    return users[ownerFirebaseUid];
  }

  Future<FirebaseUser?> ownerProfile({bool forceRefresh = false}) async {
    var ownerUid = FirebaseService.instance.ownerFirebaseUid;
    if (ownerUid != null) {
      var owner = await userHasFirebaseUid(ownerUid, forceRefresh: forceRefresh);
      if (owner != null) {
        return owner;
      }
    }
    return null;
  }
}