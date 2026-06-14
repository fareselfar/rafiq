class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String role;
  final int? age;
  final String? gender;
  final String? specialization;
  final String? description;
  final double? price;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.age,
    this.gender,
    this.specialization,
    this.description,
    this.price,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
    if (age != null) map['age'] = age;
    if (gender != null) map['gender'] = gender;
    if (specialization != null) map['specialization'] = specialization;
    if (description != null) map['description'] = description;
    if (price != null) map['price'] = price;
    return map;
  }
}
