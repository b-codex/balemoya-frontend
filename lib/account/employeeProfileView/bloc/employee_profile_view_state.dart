part of 'employee_profile_view_bloc.dart';

@immutable
abstract class EmployeeProfileViewState {}

class EmployeeProfileViewInitial extends EmployeeProfileViewState {}

class AccountReported extends EmployeeProfileViewState {}

class AccountNotReported extends EmployeeProfileViewState {}
