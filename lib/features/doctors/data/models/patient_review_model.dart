import '../../domain/entities/patient_review.dart';

class PatientReviewModel extends PatientReview {
  const PatientReviewModel({
    required super.patientName,
    required super.comment,
    required super.timeAgo,
    super.patientImageUrl,
  });

  factory PatientReviewModel.fromJson(Map<String, dynamic> json) {
    return PatientReviewModel(
      patientName: json['patient_name'] ?? '',
      comment: json['comment'] ?? '',
      timeAgo: json['time_ago'] ?? '',
      patientImageUrl: json['patient_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_name': patientName,
      'comment': comment,
      'time_ago': timeAgo,
      'patient_image_url': patientImageUrl,
    };
  }
}
