import 'package:blog_application/features/auth/domain/entities/user_entities.dart';
class UserModel extends UserEntities {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  } 
}
