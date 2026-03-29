class SuccessResponse {
  SuccessResponse({
      Success? success,}){
    _success = success;
}

  SuccessResponse.fromJson(dynamic json) {
    _success = json['ok'] != null ? Success.fromJson(json['ok']) : null;
  }
  Success? _success;
SuccessResponse copyWith({  Success? success,
}) => SuccessResponse(  success: success ?? _success,
);
  Success? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_success != null) {
      map['ok'] = _success?.toJson();
    }
    return map;
  }

}

/// message : "PASSWORD_RESET_EMAIL_SENT"

class Success {
  Success({
      String? message,}){
    _message = message;
}

  Success.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
Success copyWith({  String? message,
}) => Success(  message: message ?? _message,
);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}