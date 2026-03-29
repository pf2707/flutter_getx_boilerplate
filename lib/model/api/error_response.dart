import 'package:flutter_getx_boilerplate/constant/constant.dart';

class ErrorResponse {
  final String? errorCode;
  final String? message;

  ErrorResponse({
    this.errorCode,
    this.message,
  });

  ErrorResponse.noNetwork() :
      this(errorCode: "no_network", message: "No network connection");

  factory ErrorResponse.fromJson(dynamic json) {
    return ErrorResponse(
      errorCode: json['error'],
      message: json['message'],
    );
  }
}

/// message : "INVALID_TOKEN"
/// status : 401

class Error {
  Error({
    String? errorCode,
    String? message,
      int? status,}){
    _errorCode = errorCode;
    _message = message;
    _status = status;
}

  Error.fromJson(dynamic json) {
    _errorCode = json['errorCode'];

    var msgInfo = json['message'];
    if (msgInfo is String) {
      _message = msgInfo;
    } else if (msgInfo is List<String>) {
      _message = msgInfo.first;
    } else {
      _message = msgInfo.toString();
    }
    _status = json['code'];
  }
  String? _errorCode;
  String? _message;
  int? _status;
Error copyWith({
  String? errorCode,
  String? message,
  int? status,
}) => Error( errorCode: errorCode ?? _errorCode,
  message: message ?? _message,
  status: status ?? _status,
);
  String? get errorCode => _errorCode;
  String? get message => _message;
  int? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorCode'] = _errorCode;
    map['message'] = _message;
    map['code'] = _status;
    return map;
  }
}

class LoginErrorResponse {
  final EnumLoginError error;
  final String? message;

  LoginErrorResponse({required this.error, this.message});
}