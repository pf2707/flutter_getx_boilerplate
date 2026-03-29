
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_getx_boilerplate/constant/constant.dart';
import 'package:get/get.dart';

class FirebaseUser {
  String firebaseRefId;
  UserObj user;

  FirebaseUser({
    required this.firebaseRefId,
    required this.user,
  });
}

class UserObj {
  String name;
  String? email;

  UserObj({
    required this.name,
    this.email
  });

  UserObj.fromCredential({
    required UserCredential user,
    required EnumLoginProvider provider,
  }) : name = "player".tr {
    name = user.user?.displayName ?? "player".tr;
    email = user.user?.email;;
  }

  UserObj.fromJson(dynamic json)
      : name = "player".tr {
    name = json['name'] ?? "player".tr;
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = name;
    if (email != null) { map['email'] = email; }
    return map;
  }
}

class LoginProvider {
  EnumLoginProvider? provider;

  LoginProvider({
    this.provider,
  });

  LoginProvider.fromJson(dynamic json) {
    try {
      var providerString = json['provider'] as String?;
      if (providerString != null) {
        provider = EnumLoginProvider.from(providerString);
      }
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (provider != null) { map['provider'] = provider!.param; }
    return map;
  }
}