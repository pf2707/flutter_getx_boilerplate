
class Api1Request {
  int? a;
  Api1Request({
    this.a,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['a'] = a;
    return map;
  }
}