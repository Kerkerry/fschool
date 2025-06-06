import 'dart:convert';

import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/src/student/domain/entities/student.dart';

class StudentModel extends Student{
  const StudentModel({
    required super.id,
    required super.username,
    required super.password,
    required super.email,
    required super.role,
    required super.firstName,
    required super.lastName,
    required super.createdAt,
    required super.lastLogin});

   StudentModel.fromMap(DataMap map):this(
    id: map['user_id'],
    username: map['username'],
    password: map['password_hash'],
    email: map['email'],
    role: map['role'],
    firstName: map['first_name'],
    lastName: map['last_name'],
    createdAt: DateTime.tryParse(map['created_at']),
    lastLogin: DateTime.tryParse(map['last_login'])
  );

   StudentModel fromJson(String source)=>StudentModel.fromMap(jsonDecode(source) as DataMap);

   StudentModel copyWith(
      {
        String? username,
        String?password,
        String?email,
        String?role,
        String?firstName,
        String?lastName,
        DateTime?lastLogin
      }
      ){
       return StudentModel(
           id: id,
           username: username??this.username,
           password: password??this.password,
           email: email??this.email,
           role:role??this.role ,
           firstName: firstName??this.firstName,
           lastName: lastName??this.lastName,
           createdAt: createdAt,
           lastLogin: lastLogin??this.lastLogin);
     }

   DataMap toMap()=>{
     'user_id':id,
     'username':username,
     'password_hash':password,
     'email':email,
     'first_name':firstName,
     'last_name':lastName,
     'last_login':lastLogin
   };

   String toJson()=>jsonEncode(toMap());
   
   @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}