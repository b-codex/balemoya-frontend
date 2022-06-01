import 'package:balemoya/account/employeeProfileView/models/models.dart';
import 'package:balemoya/account/employeeProfileView/repository/repository.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_profile_view_event.dart';
part 'employee_profile_view_state.dart';

class EmployeeProfileViewBloc
    extends Bloc<EmployeeProfileViewEvent, EmployeeProfileViewState> {
  final EmployeeProfileViewRepository employeeProfileViewRepository;

  EmployeeProfileViewBloc({required this.employeeProfileViewRepository})
      : super(EmployeeProfileViewInitial()) {
    SharedPreference sharedPreference = SharedPreference();

    on<ReportAccount>((event, emit) async {
      final sessionID = await sharedPreference.getSession().then(
        (value) {
          return value;
        },
      );
      final response = await employeeProfileViewRepository.reportAccount(
        reportModel: event.reportModel,
        sessionID: sessionID,
      ) as Map;
      print(response);
      if (response['success']) {
        emit(AccountReported());
      } else {
        emit(AccountNotReported());
      }
    });
  }
}
