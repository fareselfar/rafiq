class ChangePassRequest {
  ChangePassRequest({
      this.confirmPassword, 
      this.currentPassword, 
      this.newPassword,});

  ChangePassRequest.fromJson(dynamic json) {
    confirmPassword = json['confirmPassword'];
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
  }
  String? confirmPassword;
  String? currentPassword;
  String? newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['confirmPassword'] = confirmPassword;
    map['currentPassword'] = currentPassword;
    map['newPassword'] = newPassword;
    return map;
  }

}