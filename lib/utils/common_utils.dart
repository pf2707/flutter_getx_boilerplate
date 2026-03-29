
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:share_plus/share_plus.dart';

class CommonUtils {

  /// Font Perfect Dark
  static TextStyle fontPerfectDarkW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Perfect Dark', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }

  /// Font Zorque
  static TextStyle fontZorqueW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0, bool switchToVietnameseSupport = false}) {
    if (switchToVietnameseSupport) {
      return TextStyle(fontFamily: 'DVN - Fredoka', fontWeight: FontWeight.w700, fontSize: fontSize, color: color, height: lineHeight);
    }
    return TextStyle(fontFamily: 'Zorque', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }

  /// Font Power Smash
  static TextStyle fontPowerSmashW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Power Smash', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }

  /// Font Kaira
  static TextStyle fontKairaW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Kaira', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }

  /// Font Jared
  static TextStyle fontJaredW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Jared', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }

  /// Font GlooberLine
  static TextStyle fontGlooberLineW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Gloober Line', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }

  /// Font Gloober
  static TextStyle fontGlooberW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Gloober', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }

  /// Font DangerNight-PersonalUse
  // static TextStyle fontDangerNightW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
  //   return TextStyle(fontFamily: 'Danger Night - Personal Use', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  // }

  /// Font Poppins
  static TextStyle fontPoppinsW900(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW900Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW800(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW800Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW700(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW700Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW600(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW600Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW500(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW500Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW400(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsw400Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW300(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW300Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW200(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w200, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW200Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w200, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW100(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w100, fontSize: fontSize, color: color, height: lineHeight);
  }
  static TextStyle fontPoppinsW100Italic(double fontSize, {Color color = Colors.white, double lineHeight = 1.0}) {
    return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w100, fontStyle: FontStyle.italic, fontSize: fontSize, color: color, height: lineHeight);
  }

  static showAlertDialog({required BuildContext context, required String content, String title = "Message", String button = "Close"}) async {
    await FlutterPlatformAlert.showCustomAlert(
      windowTitle: title,
      text: content,
      positiveButtonTitle: button
    );
  }

  static shareMatchJoinUrl(String url, String code) {
    try {
      final uri = Uri.parse(url);
      SharePlus.instance.share(
        ShareParams(
          uri: uri,
          subject: "Join my match with code $code",
          title: "Join my match with code $code",
        )
      );
    } catch (e) {
      shareMatchCode(code);
    }
  }

  static shareMatchCode(String code) {
    final title = "Join My Justice Scale Battle! ⚖️ Match Code: $code";
    final desc = """
    MATCH CODE:  [ $code ]
    Hey everyone! I've just created a thrilling match in Justice Scale Game – the ultimate game of balance, strategy, and justice! Want to join the action?
    
    Use this unique code: [ $code ] to enter the arena.
    
    Gather your wits, tip the scales, and let's see who claims victory! Download Justice Scale if you haven't already:
     + AppStore: https://apps.apple.com/us/app/justice-scale/id6756100050
     + Google Play Store: https://play.google.com/store/apps/details?id=com.shinhana.game.justicescale
    Who's in? Tag your friends! #justicescale #balancescale #survivalgame #kdiamond
    """;
    SharePlus.instance.share(
      ShareParams(
        text: desc,
        title: title,
        subject: title
      ),
    );
  }
}