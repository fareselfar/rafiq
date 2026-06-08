class ResetPaswwordResponse {
  ResetPaswwordResponse({
      this.isSuccess, 
      this.message,});

  ResetPaswwordResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }
  bool? isSuccess;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    return map;
  }

}