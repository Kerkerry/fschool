import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/usecases/create_student.dart';

abstract class StudentRepository{
  const StudentRepository();
  ResulVoid createStudent({required CreateStudentParams student});
  ResultFuture<List<Student>> getStudents();
  ResultFuture<Student> getStudent({required int id});
  ResulVoid updateStudent({required Student student});
  ResulVoid deleteStudent({required int id});
  ResultFuture<bool> loginStudent({required CreateStudentParams student});
}