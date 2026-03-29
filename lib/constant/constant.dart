
class Constant {

}

class ConstantKeys {
  /// Save To Preference Keys
  static const keyAppLanguage = 'keyAppLanguage';
}

enum EnumLoginProvider {
  anonymous,
  google,
  apple,
  tiktok;

  static EnumLoginProvider from(String provider) {
    switch (provider) {
      case "google": return EnumLoginProvider.google;
      case "apple": return EnumLoginProvider.apple;
      case "tiktok": return EnumLoginProvider.tiktok;
      default: return EnumLoginProvider.anonymous;
    }
  }

  String get title {
    switch (this) {
      case EnumLoginProvider.google: return "Google";
      case EnumLoginProvider.apple: return "Apple";
      case EnumLoginProvider.tiktok: return "Tiktok";
      default: return "anonymous";
    }
  }

  String get param {
    switch (this) {
      case EnumLoginProvider.google: return "google";
      case EnumLoginProvider.apple: return "apple";
      case EnumLoginProvider.tiktok: return "tiktok";
      default: return "anonymous";
    }
  }
}

enum EnumLoginError {
  unknown,

  // login and link account flow
  firebaseOperationNotAllow,
  anonymousSessionNotFound,
  accountIsLinked,
  providerIsAlreadyLinkedToThisAccount,
  credentialIsLinkedToAnotherAccount,
  invalidCredential,

  // unlink account flow
  noAuthorizedUserFound,
  noSuchProvider,
  requiredReAuthenticate,
}