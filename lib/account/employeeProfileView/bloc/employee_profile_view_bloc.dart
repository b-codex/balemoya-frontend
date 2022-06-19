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

/// The EmployeeProfileViewBloc constructor takes an EmployeeProfileViewRepository as a required
/// parameter and calls the super constructor with the EmployeeProfileViewInitial state
/// 
/// Args:
///   EmployeeProfileViewInitial: This is the initial state of the bloc.
  EmployeeProfileViewBloc({
    required this.employeeProfileViewRepository,
  }) : super(EmployeeProfileViewInitial()) {
    /// Creating an instance of the SharedPreference class.
    SharedPreference sharedPreference = SharedPreference();

    /// A function that is called when the event is dispatched.
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

      if (response['success']) {
        emit(AccountReported());
      } else {
        emit(AccountNotReported());
      }
    });
  }
}
