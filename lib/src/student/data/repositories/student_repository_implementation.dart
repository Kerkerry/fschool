import 'package:dartz/dartz.dart';
import 'package:school/core/errors/api_exception.dart';
import 'package:school/core/errors/api_failure.dart';
import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/src/student/data/datasources/student_remote_datasource.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/repositories/student_repository.dart';
import 'package:school/src/student/domain/usecases/create_student.dart';

class StudentRepositoryImplementation implements StudentRepository{
  final StudentRemoteDatasource _rmdts;
  StudentRepositoryImplementation({required StudentRemoteDatasource remoteDatasource}):_rmdts=remoteDatasource;

  @override
  ResulVoid createStudent({required CreateStudentParams student}) async{
    try{
      await _rmdts.createStudent(student: student);
      return const Right(null);
    }on ApiException catch(e){
        return left(ApiFailure.fromException(e));
    }
  }

  @override
  ResulVoid deleteStudent({required int id})async {
    try{
      await _rmdts.deleteStudent(id: id);
      return const Right(null);
    }on ApiException catch(e){
      return left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Student> getStudent({required int id}) async{
    try{
      final result=await _rmdts.getStudent(id: id);
      return  Right(result);
    }on ApiException catch(e){
      return left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Student>> getStudents() async{
    try{
      final result=await _rmdts.getStudents();
      return  Right(result);
    }on ApiException catch(e){
      return left(ApiFailure.fromException(e));
    }
  }

  @override
  ResulVoid updateStudent({required Student student}) async{
    try{
      await _rmdts.updateStudent(student: student);
      return const Right(null);
    }on ApiException catch(e){
      return left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> loginStudent({required CreateStudentParams student}) async{
    // TODO: implement loginStudent
    throw UnimplementedError();
  }
}