class RegisterResponse {
  RegisterResponse({
      this.displayName, 
      this.email, 
      this.token,});

  RegisterResponse.fromJson(dynamic json) {
    displayName = json['displayName'];
    email = json['email'];
    token = json['token'];
  }
  String? displayName;
  String? email;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['displayName'] = displayName;
    map['email'] = email;
    map['token'] = token;
    return map;
  }

}