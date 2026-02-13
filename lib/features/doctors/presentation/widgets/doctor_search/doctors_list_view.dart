import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/doctors/data/datasources/mock_doctors_service.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';
import 'doctor_card/doctor_card.dart';

class DoctorsListView extends StatelessWidget {
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorsList = _getDummyDoctors();

    if (doctorsList.isEmpty) {
      return Center(
        child: Text("لا يوجد أطباء متاحون حالياً", style: AppTypography.bodyLarge),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
      itemCount: doctorsList.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctor: doctorsList[index]);
      },
    );
  }
  List<DoctorsModel> _getDummyDoctors() {
    return MockDoctorsService.dummyDoctors; 
  }
}




//   List<DoctorsModel> _getDummyDoctors() {
//   return [
//     const DoctorsModel(
//       id: 1,
//       name: "د. مالك محمد حماد",
//       specialization: "أخصائي عظام",
//       rating: 4.9,
//       reviewCount: 120,
//       address: "طنطا - أول شارع البحر",
//       imageUrl: "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
//       consultationPrice: 200,
//       availability: DoctorAvailability.availableNow,
//       bio: "خبير في جراحة العظام والمفاصل وتأهيل الإصابات الرياضية.",
//       yearsOfExperience: 10,
//       patientCount: 500,
//       waitingTime: 15,
//       workingHours: [], 
//       reviews: [],
//     ),

//     const DoctorsModel(
//       id: 2,
//       name: "د. سارة محمود أحمد",
//       specialization: "أخصائية جلدية وتجميل",
//       rating: 4.7,
//       reviewCount: 85,
//       address: "المنصورة - حي الجامعة",
//       imageUrl: "https://cdn-icons-png.flaticon.com/512/6069/6069189.png",
//       consultationPrice: 250,
//       availability: DoctorAvailability.availableTomorrow,
//       bio: "متخصصة في علاج الأمراض الجلدية المزمنة وأحدث تقنيات الليزر.",
//       yearsOfExperience: 6,
//       patientCount: 1200,
//       waitingTime: 10,
//       workingHours: [],
//       reviews: [],
//     ),

//     const DoctorsModel(
//       id: 3,
//       name: "د. رامي إسماعيل",
//       specialization: "استشاري جراحة القلب",
//       rating: 5.0,
//       reviewCount: 2100,
//       address: "القاهرة - مدينة نصر",
//       imageUrl: "https://cdn-icons-png.flaticon.com/512/9248/9248253.png",
//       consultationPrice: 500,
//       availability: DoctorAvailability.unavailable,
//       bio: "استشاري جراحة القلب والأوعية الدموية بمستشفى دار الفؤاد.",
//       yearsOfExperience: 20,
//       patientCount: 3500,
//       waitingTime: 45,
//       workingHours: [],
//       reviews: [],
//     ),

//     const DoctorsModel(
//       id: 4,
//       name: "د. أحمد الشرقاوي",
//       specialization: "أخصائي طب الأطفال",
//       rating: 4.2,
//       reviewCount: 45,
//       address: "الإسكندرية - سموحة",
//       imageUrl: "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
//       consultationPrice: 150,
//       availability: DoctorAvailability.availableNow,
//       bio: "طبيب أطفال متخصص في تغذية الرضع ومتابعة النمو.",
//       yearsOfExperience: 4,
//       patientCount: 200,
//       waitingTime: 5,
//       workingHours: [],
//       reviews: [],
//     ),
//   ];
// }
