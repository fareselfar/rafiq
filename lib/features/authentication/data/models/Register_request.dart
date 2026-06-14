class RegisterRequest {
  RegisterRequest({
      this.email, 
      this.name, 
      this.password, 
      this.role, 
      this.age, 
      this.gender, 
      this.specialization, 
      this.description, 
      this.price,});

  RegisterRequest.fromJson(dynamic json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    role = json['role'];
    age = json['age'];
    gender = json['gender'];
    specialization = json['specialization'];
    description = json['description'];
    price = json['price'];
  }
  String? email;
  String? name;
  String? password;
  String? role;
  int? age;
  String? gender;
  String? specialization;
  String? description;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['name'] = name;
    map['password'] = password;
    map['role'] = role;
    map['age'] = age;
    map['gender'] = gender;
    map['specialization'] = specialization;
    map['description'] = description;
    map['price'] = price;
    return map;
  }

}