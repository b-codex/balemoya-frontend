part of 'employee_profile_view_bloc.dart';

@immutable
abstract class EmployeeProfileViewEvent {}

class ReportAccount extends EmployeeProfileViewEvent {
  final ReportModel reportModel;

  ReportAccount({required this.reportModel});
}
