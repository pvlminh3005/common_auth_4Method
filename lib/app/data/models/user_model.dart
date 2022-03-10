import 'dart:convert';

class UserModel {
  UserModel({
    required this.uid,
    this.name,
    this.avatar,
    this.username,
    this.fcmToken,
    this.email,
    this.phone,
  });

  final String uid;
  final String? name;
  final String? avatar;
  final String? username;
  final String? fcmToken;
  final String? email, phone;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'username': username,
      'fcmToken': fcmToken,
      'email': email,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      username: map['username'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
