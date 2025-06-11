// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Murid {
  final int? id;
  final String username;
  final String email;
  final String password;

  Murid({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory Murid.fromMap(Map<String, dynamic> map) {
    return Murid(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Murid.fromJson(String source) =>
      Murid.fromMap(json.decode(source) as Map<String, dynamic>);
}
