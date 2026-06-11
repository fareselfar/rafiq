import 'package:rafiq/features/patient_side/authentication/domain/entities/auth_entity.dart';

class LoginResponse {
  LoginResponse({this.displayName, this.email, this.token});

  LoginResponse.fromJson(dynamic json) {
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

  AuthEntity toAuthEntity() {
    return AuthEntity(email: email, name: displayName, role: '');
  }
}
