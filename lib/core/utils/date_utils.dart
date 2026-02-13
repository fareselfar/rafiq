String formatDate(DateTime date) {
  final weekDays = ['الأحد','الاثنين','الثلاثاء','الأربعاء','الخميس','الجمعة','السبت'];
  final months = ['يناير','فبراير','مارس','أبريل','مايو','يونيو','يوليو','أغسطس','سبتمبر','أكتوبر','نوفمبر','ديسمبر'];

  // Flutter weekday: 1=Mon ... 7=Sun
  String dayName = weekDays[date.weekday % 7];
  String day = date.day.toString();
  String month = months[date.month - 1];
  String year = date.year.toString();

  return "$dayName، $day $month $year";
}