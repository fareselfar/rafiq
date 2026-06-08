class ResetPasswordResponse {
  ResetPasswordResponse({
      this.isSuccess, 
      this.message,});

  ResetPasswordResponse.fromJson(dynamic json) {
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