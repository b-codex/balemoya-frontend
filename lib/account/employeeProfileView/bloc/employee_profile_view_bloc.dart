import 'package:balemoya/account/employeeProfileView/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_profile_view_event.dart';
part 'employee_profile_view_state.dart';

class EmployeeProfileViewBloc
    extends Bloc<EmployeeProfileViewEvent, EmployeeProfileViewState> {
  final EmployeeProfileViewRepository employeeProfileViewRepository;

  EmployeeProfileViewBloc({required this.employeeProfileViewRepository})
      : super(EmployeeProfileViewInitial()) {
    on<EmployeeProfileViewEvent>((event, emit) {
      print('event from EmployeeProfileViewBloc $event');
    });
  }
}
