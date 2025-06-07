import 'dart:convert';

import 'package:school/core/constants.dart';
import 'package:school/core/errors/api_exception.dart';
import 'package:school/core/errors/log_helper.dart';
import 'package:school/src/student/data/datasources/student_remote_datasource.dart';
import 'package:school/src/student/data/models/student_model.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/usecases/create_student.dart';
import 'package:http/http.dart' as http;
class StudentDatasourceImplementation implements StudentRemoteDatasource{
  const StudentDatasourceImplementation();

  @override
  Future<void> createStudent({required CreateStudentParams student}) async{
      try{
        final response=await http.post(
            Uri.https(kBaseUrl,createStudentEndpoint),
            body:jsonEncode(
              {
                'username':student.username,
                'password':student.password,
                'role':student.role,
                'email':student.email,
                'first_name':student.firstName,
                'last_name':student.lastName
              }
            ),
            headers: {'Content-Type':'application/json'}
        );
        if(response.statusCode!=200){
          throw(ApiException(statusCode: response.statusCode,message: response.body));
        }
        logger.d(response.body);
      }
      on ApiException{
        rethrow;
      }
      catch (e){
        throw(ApiException(statusCode: 500,message: e.toString()));
      }
  }

  @override
  Future<void> deleteStudent({required int id})async {
    try{
      final response=await http.delete(Uri.https(kBaseUrl,"$getStudentsEndpoint/$id"));
      if(response.statusCode!=200){
        throw(ApiException(statusCode: response.statusCode,message: response.body));
      }
      logger.d(response.body);
    }on ApiException{
      rethrow;
    }
    catch(e){
      throw(ApiException(statusCode: 500,message: e.toString()));
    }
  }

  @override
  Future<Student> getStudent({required int id}) async{

    try{
      final response=await http.get(Uri.https(kBaseUrl,"$getStudentsEndpoint/$id"));
      logger.d(response.body);
      if(response.statusCode!=200){
        throw(ApiException(statusCode: response.statusCode,message: response.body));
      }
      return StudentModel.fromMap(jsonDecode(response.body));
    }on ApiException{
      rethrow;
    }
    catch(e){
      throw(ApiException(statusCode: 500,message: e.toString()));
    }
  }

  @override
  Future<List<Student>> getStudents()async {
    try{
      final response=await http.get(Uri.https(kBaseUrl,getStudentsEndpoint));
      if(response.statusCode!=200){
        throw(ApiException(statusCode: response.statusCode,message: response.body));
      }
      final studentsResponse=jsonDecode(response.body);
      return List.from(studentsResponse['students'] as List).map((student)=>StudentModel.fromMap(student)).toList();
    }on ApiException{
      rethrow;
    }
    catch(e){
      throw(ApiException(statusCode: 500,message: e.toString()));
    }
  }

  @override
  Future<void> updateStudent({required Student student})async {
    try{
      final response=await http.put(
          Uri.https(kBaseUrl,updateStudentEndpoint),
          body:jsonEncode(
            {
              'user_id':student.id,
              'username':student.username,
              'password_hash':student.password,
              'role':student.role,
              'email':student.email,
              'first_name':student.firstName,
              'last_name':student.lastName,
              'last_login':student.lastLogin.toString()
            }
          ),
          headers: {'Content-Type':'application/json'}
      );
      if(response.statusCode!=200){
        throw(ApiException(statusCode: response.statusCode,message: response.body));
      }
    }
    on ApiException{
      rethrow;
    }
    catch (e){
      throw(ApiException(statusCode: 500,message: e.toString()));
    }
  }

  @override
  Future<bool> loginStudent({required CreateStudentParams student})async {
    try{
      final response=await http.post(
          Uri.https(kBaseUrl,loginStudentEndpoint),
          body:jsonEncode(
              {
                'username':student.username,
                'password':student.password,
                'role':student.role,
                'email':student.email,
                'first_name':student.firstName,
                'last_name':student.lastName
              }
          ),
          headers: {'Content-Type':'application/json'}
      );
      if(response.statusCode!=200){
        throw(ApiException(statusCode: response.statusCode,message: response.body));
      }
      logger.d(response.body);
      final  loginResponse=jsonDecode(response.body);
      return loginResponse['login'];
    }
    on ApiException{
      rethrow;
    }
    catch (e){
      throw(ApiException(statusCode: 500,message: e.toString()));
    }
  }
}