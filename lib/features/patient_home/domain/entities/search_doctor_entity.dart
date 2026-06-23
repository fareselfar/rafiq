class SearchDoctorEntity {
  final int id;
  final String name;
  final String? specialization;
  final String? address;
  final String imagePath;
  final double rate;

  const SearchDoctorEntity({
    required this.id,
    required this.name,
    this.specialization,
    this.address,
    required this.imagePath,
    required this.rate,
  });
}
