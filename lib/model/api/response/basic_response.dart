
class BasicResponse {
  final bool? success;
  final String? message;

  BasicResponse({
    this.success,
    this.message,
  });

  factory BasicResponse.fromJson(dynamic json) {
    return BasicResponse(
      success: json['success'],
      message: json['message'],
    );
  }

  bool get isSuccessful => success != null && success!;
}