class LoginResponse {
  final String? token;
  final String? email;
  final String? name;
  // السيرفر بيرجع role في الـ register والـ login بنفس الـ shape
  final String? role;
  final DateTime? expiresAt;

  const LoginResponse({
    this.token,
    this.email,
    this.name,
    this.role,
    this.expiresAt,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
    );
  }
}
