import 'dart:convert';

class UserModel {
  late final String id;
  final String firebaseId;
  final String name;
  final String email;
  final String address;
  final String type;
  final String token;
  final String phone;

  UserModel({
    required this.firebaseId,
    required this.phone,
    required this.id,
    required this.name,
    required this.email,
    this.address = "",
    this.type = "",
    this.token = "",
  });

 

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'type': type,
      'token': token,
      'phone': phone
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        firebaseId: map['firebaseId'],
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        address: map['address'] ?? '',
        type: map['type'] ?? '',
        token: map['token'] ?? '',
        phone: map['phone'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
