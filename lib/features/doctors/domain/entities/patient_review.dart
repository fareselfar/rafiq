import 'package:equatable/equatable.dart';

class PatientReview extends Equatable {
  final String patientName;
  final String comment;
  final String timeAgo;
  final String? patientImageUrl;

  const PatientReview({
    required this.patientName,
    required this.comment,
    required this.timeAgo,
    this.patientImageUrl,
  });

  @override
  List<Object?> get props => [patientName, comment, timeAgo, patientImageUrl];
}
