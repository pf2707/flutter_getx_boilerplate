
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/constant/app_colors.dart';
import 'package:flutter_getx_boilerplate/screen/a/a_screen.dart';
import 'package:flutter_getx_boilerplate/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum NavigationIdentifier {
  screenDashboard,
  screenA,
}

class NavigationHelper {

  static final List<NavigationIdentifier> _navigationStack = [];

  static initialize(NavigationIdentifier identifier) {
    _navigationStack.clear();
    _addToStack(identifier);
  }
  
  static _addToStack(NavigationIdentifier identifier) {
    _navigationStack.add(identifier);
  }

  static Future<dynamic> _goToScreenWithTransition(dynamic screen, {required Transition transition, Duration duration = const Duration(milliseconds: 300), bool isWaiting = false}) async {
    if (isWaiting) {
      return await Get.to(screen, transition: transition, duration: duration, popGesture: false);
    } else {
      Get.to(screen, transition: transition, duration: duration, popGesture: false);
    }
  }

  static closeSpecific({required NavigationIdentifier identifier, dynamic params}) {
    _close(identifier: identifier, params: params);
  }

  static _close({required NavigationIdentifier identifier, dynamic params}) {
    final last = _navigationStack.last;
    bool canClose = last == identifier;
    if (canClose) {
      _navigationStack.removeLast();
      Get.back(result: params);
    }
  }
  static _closeAnyway({dynamic params}) {
    Get.back(result: params);
  }

  static goToHome() {
    _navigationStack.clear();
    _addToStack(NavigationIdentifier.screenDashboard);
    Get.offAll(() => const DashboardScreen(), transition: Transition.circularReveal, duration: const Duration(milliseconds: 800));
  }

  static bool _canNavigateTo(NavigationIdentifier ni) {
    bool canNavigate = _navigationStack.isEmpty || _navigationStack.last != ni;
    return canNavigate;
  }

  static goToScreenA({String? code}) {
    if (_canNavigateTo(NavigationIdentifier.screenA)) {
      _addToStack(NavigationIdentifier.screenA);
      _goToScreenWithTransition(() => AScreen(code: code,), transition: Transition.fadeIn);
    }
  }
  static closeScreenA() {
    _close(identifier: NavigationIdentifier.screenA);
  }
}