import '../../domain/entities/home_layout_entity.dart';

class HomeLayoutModel extends HomeLayoutEntity {
  const HomeLayoutModel({required super.id, required super.name});

  factory HomeLayoutModel.fromJson(Map<String, dynamic> json) {
    return HomeLayoutModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
