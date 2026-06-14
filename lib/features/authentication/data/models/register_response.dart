class RegisterResponse {
  final String token;
  final String email;
  final String name;
  final String role;
  final DateTime? expiresAt;

  const RegisterResponse({
    required this.token,
    required this.email,
    required this.name,
    required this.role,
    this.expiresAt,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json['token'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
    );
  }
}
