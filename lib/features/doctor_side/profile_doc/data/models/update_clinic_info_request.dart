class UpdateClinicInfoRequest {
  final String medicalLicense;
  final String clinicName;
  final String address;
  final String workHours;
  final double price;

  const UpdateClinicInfoRequest({
    required this.medicalLicense,
    required this.clinicName,
    required this.address,
    required this.workHours,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'medicalLicense': medicalLicense,
      'clinicName': clinicName,
      'address': address,
      'workHours': workHours,
      'price': price,
    };
  }
}
