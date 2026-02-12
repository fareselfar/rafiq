import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/features/doctors/data/models/doctors_model.dart';
import 'package:rafiq/features/doctors/domain/entities/patient_review.dart';
import 'package:rafiq/features/doctors/domain/entities/working_hours.dart';

final List<DoctorsModel> fakeDoctors = [
  DoctorsModel(
    id: 1,
    name: 'د. مالك محمد حماد',
    specialization: 'أخصائي عظام',
    rating: 4.9,
    reviewCount: 320,
    address: 'طنطا – أول شارع البحر',
    imageUrl: 'assets/images/doc.jpg',
    availability: DoctorAvailability.availableNow,
    consultationPrice: 150,
    yearsOfExperience: 8,
    patientCount: 500,
    waitingTime: 15,
    bio: 'طبيب متخصص في علاج أمراض وإصابات العظام والمفاصل والعمود الفقري، حاصل على تدريب معتمد في تشخيص وعلاج الكسور، آلام الظهر والرقبة، خشونة المفاصل، وإصابات الملاعب.',
    workingHours: [
      WorkingHours(day: 'السبت', time: '10:00 ص - 4:00 م'),
      WorkingHours(day: 'الأحد', time: '10:00 ص - 4:00 م'),
      WorkingHours(day: 'الاثنين', time: '10:00 ص - 4:00 م'),
      WorkingHours(day: 'الثلاثاء', time: '10:00 ص - 4:00 م'),
      WorkingHours(day: 'الأربعاء', time: '10:00 ص - 4:00 م'),
      WorkingHours(day: 'الخميس', time: 'مغلق', isClosed: true),
      WorkingHours(day: 'الجمعة', time: 'مغلق', isClosed: true),
    ],
    reviews: [
      PatientReview(
        patientName: 'أحمد سامح',
        comment: 'طبيب ممتاز جداً، متابع جيد وحريص على شرح الحالة بالتفصيل. العيادة نظيفة جداً والطاقم محترم.',
        timeAgo: 'منذ أسبوعين',
      ),
    ],
  ),
  DoctorsModel(
    id: 2,
    name: 'د. محمد علي',
    specialization: 'أخصائي قلب',
    rating: 4.5,
    reviewCount: 150,
    address: 'القاهرة – مدينة نصر',
    imageUrl: 'assets/images/doc.jpg',
    availability: DoctorAvailability.availableTomorrow,
    consultationPrice: 200,
    yearsOfExperience: 12,
    patientCount: 1200,
    waitingTime: 30,
    bio: 'استشاري أمراض القلب والأوعية الدموية، متخصص في قسطرة القلب وتخطيط صدى القلب.',
    workingHours: [
      WorkingHours(day: 'السبت', time: '12:00 م - 8:00 م'),
    ],
    reviews: [],
  ),
];