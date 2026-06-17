import 'dart:io';

class UpdateDoctorProfileRequest {
  final String fullName;
  final String email;
  final String phone;
  final String bio;
  final File? image;

  const UpdateDoctorProfileRequest({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.bio,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'FullName': fullName,
      'Email': email,
      'Phone': phone,
      'Bio': bio,
    };

    if (image != null) {
      map['Image'] = image;
    }

    return map;
  }
}
