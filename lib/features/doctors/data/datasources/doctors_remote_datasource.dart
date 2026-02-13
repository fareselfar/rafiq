import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';

abstract class DoctorsRemoteDataSource {
  Future<List<DoctorsModel>> getDoctors();
}

class DoctorsRemoteDataSourceImpl implements DoctorsRemoteDataSource {
  @override
  Future<List<DoctorsModel>> getDoctors() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const DoctorsModel(
        id: 1,
        name: 'د. مالك محمد حماد',
        specialization: 'أخصائي عظام',
        rating: 4.9,
        reviewCount: 320,
        address: 'طنطا - أول شارع البحر',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3774/3774299.png',
        availability: DoctorAvailability.availableNow,
        consultationPrice: 150,
        yearsOfExperience: 8,
        patientCount: 500,
        waitingTime: 15,
        bio: 'طبيب متخصص في علاج أمراض وإصابات العظام والمفاصل...',
        workingHours: [], 
        reviews: [],
      ),
    ];
  }
}