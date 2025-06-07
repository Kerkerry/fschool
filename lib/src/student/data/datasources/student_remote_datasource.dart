import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/usecases/create_student.dart';

abstract class StudentRemoteDatasource{
  const StudentRemoteDatasource();
  Future<void> createStudent({required CreateStudentParams student});
  Future<Student> getStudent({required int id});
  Future<List<Student>> getStudents();
  Future<void> updateStudent({required Student student});
  Future<void> deleteStudent({required int id});
  Future<bool> loginStudent({required CreateStudentParams student});
}