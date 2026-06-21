class DoctorListModel {
  final int id;
  final String fullName;
  final String specialization;
  final String? imagePath;
  final double rate;
  final double? price;
  final String address;
  final bool isAvailableToday;

  const DoctorListModel({
    required this.id,
    required this.fullName,
    required this.specialization,
    this.imagePath,
    required this.rate,
    this.price,
    required this.address,
    required this.isAvailableToday,
  });

  factory DoctorListModel.fromJson(Map<String, dynamic> json) {
    return DoctorListModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      specialization: json['specialization'] ?? '',
      imagePath: (() {
        final p = json['imagePath'] as String?;
        if (p == null) return null;
        if (p == 'http://rafiqapp.runasp.net' || p.isEmpty) return null;
        return p;
      })(),
      rate: (json['rate'] ?? 0.0).toDouble(),
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      address: json['address'] ?? '',
      isAvailableToday: json['isAvailableToday'] ?? false,
    );
  }
}
