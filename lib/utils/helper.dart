
import 'dart:math';
import 'dart:developer' as dev;

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/model/api/error_object.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:unique_identifier/unique_identifier.dart';

class Helper {

  static resignKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<String?> getUniqueDeviceId() async {
    var deviceId = await UniqueIdentifier.serial;

    if (kDebugMode) {
      debugLog("unique device id = $deviceId");
    }

    return deviceId;
  }
}

debugLog(String msg) {
  // if (kDebugMode) {
  //   debugPrint(msg);
  // }
  // debugPrint(msg);
  dev.log(msg);
}

extension DoubleExtension on double {
  String toStringWithoutTrailingZerosAsFixed(int fractionDigits, {bool shouldGroupingSeparator = true}) {
    if (this == 0) {
      return '0';
    }
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    var str = toStringAsFixed(fractionDigits);
    String newStr = str;
    if (fractionDigits > 0) {
      newStr = str.replaceAll(regex, '');
    }

    var originString = Decimal.parse(newStr).toString();
    var arr = originString.split('.');
    if (arr.isNotEmpty) {
      var first = arr.first;

      var nf = '';
      if (first.length < 3) {
        nf = first;
      } else {
        var f = int.parse(first);

        if (shouldGroupingSeparator) {
          nf = NumberFormat('#,000').format(f);
        } else {
          nf = f.toString();
        }
      }

      if (arr.length > 1) {
        var second = arr[1];

        var result = '$nf.$second';
        return result;
      } else {
        return nf;
      }
    }

    return originString;
  }
}

extension ArrayExtension<T> on List<T> {
  T randomMember() {
    if (isEmpty) {
      throw ErrorObject("-1", "list is empty");
    }
    final index = Random().nextInt(length);
    return this[index];
  }

  Tuple2<T, T> pickTwoRandomMembers() {
    if (isEmpty) {
      throw ErrorObject("-1", "list is empty");
    }
    if (length == 1) {
      return Tuple2(first, first);
    }
    final clone = List<T>.from(this);
    final index1 = Random().nextInt(clone.length);
    final item1 = clone[index1];

    clone.removeAt(index1);
    final index2 = Random().nextInt(clone.length);
    final item2 = clone[index2];
    return Tuple2(item1, item2);
  }

  List<T> findElementsNotInOtherList(List<T> otherList, {required bool Function(T a, T b) fnEqual}) {
    if (otherList.isEmpty) {
      return List<T>.of(this);
    }
    if (isEmpty) {
      return [];
    }
    return where((a) => !otherList.any((b) => fnEqual(a, b))).toList();
  }
}

class CustomHeroDialogRoute<T> extends PageRoute<T> {
  CustomHeroDialogRoute({
    required this.builder,
    super.settings,
  });

  final WidgetBuilder builder;

  @override
  bool get opaque => false;
  @override
  Color? get barrierColor => null; // Customize barrier color
  @override
  bool get barrierDismissible => true;
  @override
  String? get barrierLabel => 'Dismiss';
  @override
  bool get maintainState => true;
  @override
  Duration get transitionDuration => const Duration(milliseconds: 800);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child); // Example transition
  }
}