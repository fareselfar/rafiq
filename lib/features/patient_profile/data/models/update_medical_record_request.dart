class UpdateMedicalRecordRequest {
  final double height;
  final double weight;
  final List<String> chronicDiseases;
  final String allergy;
  final String bloodType;

  const UpdateMedicalRecordRequest({
    required this.height,
    required this.weight,
    required this.chronicDiseases,
    required this.allergy,
    required this.bloodType,
  });

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'chronicDiseases': chronicDiseases,
      'allergy': allergy,
      'bloodType': bloodType,
    };
  }
}
