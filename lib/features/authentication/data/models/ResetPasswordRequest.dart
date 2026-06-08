class ResetPasswordRequest {
  ResetPasswordRequest({
    this.confirmPassword,
    this.email,
    this.newPassword,
    this.otp,
  });

  ResetPasswordRequest.fromJson(dynamic json) {
    confirmPassword = json['confirmPassword'];
    email = json['email'];
    newPassword = json['newPassword'];
    otp = json['otp'];
  }
  String? confirmPassword;
  String? email;
  String? newPassword;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['confirmPassword'] = confirmPassword;
    map['email'] = email;
    map['newPassword'] = newPassword;
    map['otp'] = otp;
    return map;
  }
}
