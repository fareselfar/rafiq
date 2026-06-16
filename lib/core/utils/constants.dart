/// Application Constants
/// Centralized constant definitions
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // API Configuration
  static const String baseUrl = 'https://rafiqapp.runasp.net/api';
  static const String signUpEndpoint = '/Auth/register';
  static const String signInEndpoint = '/Auth/login';
  static const String changePassEndpoint = '/Appointments/change-password';
  static const String verifyOtpEndpoint = '/Auth/verify-reset-otp';
  static const String sendResetOtpEndpoint = '/Auth/send-reset-otp';
  static const String resetPasswordEndpoint = "/Auth/reset-password";
  static const String getProfileEndpoint = '/Appointments/info';
  static const String updateProfileEndpoint = '/Appointments/update-profile';
  static const String updateMedicalRecordEndpoint =
      '/Appointments/update-medical-profile';

  static const String uploadFileEndpoint = '/Appointments/upload-file';
  static const String getUploadFileEndpoint =
      '/Appointments/my-files?fileType=string';

  static const String changePasswordEndpoint = '/Profile/change-password';
  static const String getSpecializationsEndpoint = '/Specializations/get-all';
  static const String getArticlesEndpoint = '/Articles/get-all';
  static const String getArticleByIdEndpoint = '/Articles/get-by-id';
  static const String getAppointmentsEndpoint = '/Appointments/get-all';
  static const String getAppointmentByIdEndpoint = '';

  static const String aiSocketUrl =
      'wss://rafeeq-ai-dev-production.up.railway.app/chat/ws';
  static const String apiVersion = 'v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String roleKey = 'role';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String onboardingKey = 'onboarding_completed';
  static const String tokenKey = 'token';
  static const String isFirstLaunchKey = 'is_first_launch';
}
