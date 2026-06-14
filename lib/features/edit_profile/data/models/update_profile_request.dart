import 'dart:io';

class UpdateProfileRequest {
  final String name;
  final String email;
  final String phoneNumber;
  final int age;
  final String gender;
  final File? image;

  const UpdateProfileRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Age': age,
      'Gender': gender,
    };

    if (image != null) {
      map['Image'] = image;
    }

    return map;
  }
}
