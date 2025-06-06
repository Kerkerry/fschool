import 'package:equatable/equatable.dart';
class Failure extends Equatable{
  final int statusCode;
  final String message;

  const Failure({required this.statusCode, required this.message});
  String get apiMessage=>"$statusCode: $message";
  @override
  // TODO: implement props
  List<Object?> get props => [statusCode,message];
}