import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';
import 'package:rafiq/features/doctors/data/models/patient_review_model.dart';
import 'package:rafiq/features/doctors/data/models/working_hours_model.dart';

class MockDoctorsService {
  static List<DoctorsModel> get dummyDoctors => [
    DoctorsModel(
      id: 1,
      name: 'د. مالك محمد حماد',
      specialization: 'أخصائي جراحة العظام',
      rating: 4.9,
      reviewCount: 320,
      address: 'طنطا – شارع البحر – برج الأطباء',
      imageUrl: 'assets/images/doctor_image_profile.png',
      availability: DoctorAvailability.availableNow,
      consultationPrice: 150,
      yearsOfExperience: 12,
      patientCount: 4500,
      waitingTime: 15,
      bio:
          'دكتور مالك خبير في جراحات العظام المعقدة والمناصير. حصل على دبلومة جراحة المفاصل من جامعة القاهرة. متخصص في إصابات الملاعب، وتغيير المفاصل، وعلاج انزلاق الغضاريف بأحدث التقنيات العالمية.',
      workingHours: [
        const WorkingHoursModel(
          day: 'السبت',
          time: '10:00 ص - 04:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الأحد',
          time: '10:00 ص - 04:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الاثنين',
          time: '10:00 ص - 04:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الثلاثاء',
          time: '10:00 ص - 04:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الأربعاء',
          time: '10:00 ص - 04:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الخميس',
          time: '10:00 ص - 02:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(day: 'الجمعة', time: 'مغلق', isClosed: true),
      ],
      reviews: [
        const PatientReviewModel(
          patientName: 'محمد أحمد',
          comment: 'دكتور محترم جداً وشاطر في تشخيصه، والعملية نجحت بفضل الله.',
          timeAgo: 'منذ يومين',
          patientImageUrl: 'https://via.placeholder.com/150',
        ),
        const PatientReviewModel(
          patientName: 'سارة علي',
          comment: 'العيادة منظمة جداً والدكتور بيسمع للمريض بضمير.',
          timeAgo: 'منذ أسبوع',
          patientImageUrl: 'https://via.placeholder.com/150',
        ),
      ],
    ),

    DoctorsModel(
      id: 2,
      name: 'د. سارة محمود أحمد',
      specialization: 'استشارية الجلدية والتجميل',
      rating: 4.8,
      reviewCount: 150,
      address: 'القاهرة – مدينة نصر – شارع عباس العقاد',
      imageUrl: 'assets/images/doctor_image_profile.png',
      availability: DoctorAvailability.availableTomorrow,
      consultationPrice: 250,
      yearsOfExperience: 15,
      patientCount: 3200,
      waitingTime: 20,
      bio:
          'استشارية الجلدية والتجميل والليزر. متخصصة في علاج الأمراض الجلدية المزمنة، حقن الفيلر والبوتوكس، وعلاج آثار الحروق والندبات. حاصلة على الزمالة المصرية في الأمراض الجلدية.',
      workingHours: [
        const WorkingHoursModel(
          day: 'السبت',
          time: '02:00 م - 10:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الأحد',
          time: '02:00 م - 10:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الاثنين',
          time: '02:00 م - 10:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(day: 'الثلاثاء', time: 'مغلق', isClosed: true),
        const WorkingHoursModel(
          day: 'الأربعاء',
          time: '02:00 م - 10:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الخميس',
          time: '02:00 م - 10:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(day: 'الجمعة', time: 'مغلق', isClosed: true),
      ],
      reviews: [
        const PatientReviewModel(
          patientName: 'منى القاضي',
          comment: 'أفضل دكتورة جلدية تعاملت معها، نتيجتها في الليزر ممتازة.',
          timeAgo: 'منذ 3 أيام',
          patientImageUrl: 'https://via.placeholder.com/150',
        ),
      ],
    ),

    DoctorsModel(
      id: 3,
      name: 'د. أحمد الشرقاوي',
      specialization: 'استشاري طب الأطفال وحديثي الولادة',
      rating: 4.7,
      reviewCount: 560,
      address: 'الإسكندرية – سموحة – بجوار مستشفى أندلسية',
      imageUrl: 'assets/images/doctor_image_profile.png',
      availability: DoctorAvailability.availableNow,
      consultationPrice: 200,
      yearsOfExperience: 20,
      patientCount: 8000,
      waitingTime: 10,
      bio:
          'أستاذ طب الأطفال بكلية الطب. متخصص في متابعة الأطفال المبتسرين (حديثي الولادة)، أمراض الجهاز التنفسي عند الأطفال، ومتابعة التغذية والنمو السليم منذ الولادة وحتى المراهقة.',
      workingHours: [
        const WorkingHoursModel(
          day: 'السبت',
          time: '11:00 ص - 05:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الأحد',
          time: '11:00 ص - 05:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(day: 'الاثنين', time: 'مغلق', isClosed: true),
        const WorkingHoursModel(day: 'الثلاثاء', time: 'مغلق', isClosed: true),
        const WorkingHoursModel(
          day: 'الأربعاء',
          time: '11:00 ص - 05:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الخميس',
          time: '11:00 ص - 05:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الجمعة',
          time: '01:00 م - 04:00 م',
          isClosed: false,
        ),
      ],
      reviews: [],
    ),

    DoctorsModel(
      id: 4,
      name: 'د. ليلى حسن إبراهيم',
      specialization: 'استشارية النساء والتوليد وعلاج العقم',
      rating: 4.9,
      reviewCount: 890,
      address: 'المنصورة – المشاية السفلية – حي الجامعة',
      imageUrl: 'assets/images/doctor_image_profile.png',
      availability: DoctorAvailability.availableTomorrow,
      consultationPrice: 300,
      yearsOfExperience: 18,
      patientCount: 5400,
      waitingTime: 30,
      bio:
          'متخصصة في جراحات المناظير النسائية، متابعة الحمل الحرج، وعمليات الحقن المجهري وتأخر الإنجاب. حاصلة على شهادة الخبرة من جامعة أكسفورد في طب الأجنة.',
      workingHours: [
        const WorkingHoursModel(
          day: 'السبت',
          time: '04:00 م - 11:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الأحد',
          time: '04:00 م - 11:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(day: 'الاثنين', time: 'مغلق', isClosed: true),
        const WorkingHoursModel(
          day: 'الثلاثاء',
          time: '04:00 م - 11:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الأربعاء',
          time: '04:00 م - 11:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(
          day: 'الخميس',
          time: '04:00 م - 11:00 م',
          isClosed: false,
        ),
        const WorkingHoursModel(day: 'الجمعة', time: 'مغلق', isClosed: true),
      ],
      reviews: [
        const PatientReviewModel(
          patientName: 'إيمان يوسف',
          comment:
              'دكتورة ممتازة وشاطرة جداً في متابعة الحمل، مريحة جداً في التعامل.',
          timeAgo: 'منذ شهر',
          patientImageUrl: 'https://via.placeholder.com/150',
        ),
      ],
    ),
  ];
}
