

import 'package:get/get.dart';

class ErrorObject implements Exception {

  String? errorCode;
  String? errorDescription;

  int statusCode = 0;

  ErrorObject(this.errorCode, this.errorDescription);

  ErrorObject.noNetwork() {
    errorCode = 'no_network';
    errorDescription = 'There is a problem with your connection. Please make sure your data or wifi is connected.'.tr;
  }

  ErrorObject.unknown() {
    errorCode = 'unknown_error';
    errorDescription = 'Something went wrong. Please try again later'.tr;
  }

  String get alertTitle {
    if (errorCode == 'no_network') {
      return 'Internet connection problem'.tr;
    } else if (errorCode == 'unknown_error') {
      return 'Oops'.tr;
    }
    return 'Message'.tr;
  }

  String get explanation {
    if (errorCode == 'no_network') {
      return 'There is a problem with your connection. Please make sure your data or wifi is connected.'.tr;
    } else if (errorCode == 'unknown_error') {
      return 'Something went wrong. Please try again later'.tr;
    }
    return errorDescription ?? '';
  }
}