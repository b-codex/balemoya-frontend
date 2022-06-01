import 'package:balemoya/account/employeeProfileView/data_provider/provider.dart';
import 'package:balemoya/account/employeeProfileView/models/models.dart';

class EmployeeProfileViewRepository {
  final EmployeeProfileViewProvider employeeProfileViewProvider;

  EmployeeProfileViewRepository({required this.employeeProfileViewProvider});

  Future<Object> reportAccount({
    required ReportModel reportModel,
    required List sessionID,
  }) async {
    final response = await employeeProfileViewProvider.reportAccount(
      reportModel: reportModel,
      sessionID: sessionID,
    );
    
    return response;
  }
}
