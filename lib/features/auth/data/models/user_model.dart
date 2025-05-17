import 'package:advanced_todo_app/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
       name: map['name'] ?? '',
        email: map['email'] ?? '',
        );
  }
  UserModel copyWith({//why we are copying with because we cannot modify the email as it is final so it is the alternate way to do so
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }//we have made this copywith after going to user.dart making its copy and then copy paste here user as user model
}
