import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/account/employeeProfileView/bloc/employee_profile_view_bloc.dart';
import 'package:balemoya/account/employeeProfileView/models/models.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/account/profile/models/models.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeProfileView extends StatelessWidget {
  const EmployeeProfileView({Key? key}) : super(key: key);
  static const routeName = '/employee_profile_view';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);

    /// The above code is a widget that is being returned by the build method of the StatefulWidget.
    return BlocConsumer<EmployeeProfileViewBloc, EmployeeProfileViewState>(
      listener: (context, newState) {
        /// Checking if the newState is AccountReported, if it is, it will show a snackbar.
        if (newState is AccountReported) {
          animatedSnackBar(
            context: context,
            message: 'Account Reported.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
        }

        /// Checking if the newState is AccountNotReported, if it is, it will show a snackbar with the
        /// message "Task Failed. Please Try Again."
        if (newState is AccountNotReported) {
          animatedSnackBar(
            context: context,
            message: 'Task Failed. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, newState) {
        /// The above code is a BlocConsumer widget. It is a widget that is used to listen to the state
        /// of the Bloc.
        return BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            /// Checking if the state is ProfileLoadingFailed, if it is, it will show an error message and
            /// navigate to the home screen.
            if (state is ProfileLoadingFailed) {
              animatedSnackBar(
                context: context,
                message: 'An Error Occurred. Please Try Again.',
                animatedSnackBarType: AnimatedSnackBarType.error,
              );
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home_screen', (route) => false);
            }
          },
          builder: (context, state) {
            /// Checking if the state is ProfileInitial, if it is, then it will call the LoadProfileEvent.
            if (state is ProfileInitial) {
              bloc.add(LoadProfileEvent());
            }

            /// Checking if the state is LoadingProfile, if it is, it will return a Scaffold with an
            /// AppBar widget and CircularProgressIndicator in the center.
            if (state is LoadingProfile) {
              return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            /// Checking if the state is ProfileLoadDone, if it is, it will return a Scaffold widget.
            if (state is ProfileLoadDone) {
              return Scaffold(
                appBar: _appBar(context),
                body: _body(context: context, profileModel: state.profileModel),
                // bottomSheet: ,
              );
            }
            // if (state is ProfileLoadingFailed) {
            // }
            return Scaffold(
              appBar: AppBar(),
            );
          },
        );
      },
    );
  }
}

/// It's a function that returns a widget
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Map with two keys, 'chosen' and 'filePath'
PreferredSizeWidget _appBar(context) {
  return AppBar(
    actions: [
      /// Showing a dialog when the user clicks on the popup menu item.
      PopupMenuButton(
        child: Icon(Icons.more_vert),
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              value: 'Report Account',
              child: Text(
                'Report Account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ];
        },
        onSelected: (clicked) async {
          if (clicked == 'Report Account') {
            final _formKey = GlobalKey<FormState>();
            final TextEditingController _reasonForReportController =
                TextEditingController();
            final TextEditingController _commentController =
                TextEditingController();

            /// The _reportDialog code is a dialog box that is used to report an account.
            var _reportDialog = AlertDialog(
              title: Text('Report Account'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _reasonForReportController,
                        decoration: InputDecoration(
                          label: Text("Reason For Reporting"),
                          hintText:
                              "Tell us why you want to report this account...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // initialValue: _portfolioTextController.text,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 7),
                      TextFormField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          label: Text("Comment"),
                          hintText: "Additional Comment",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // initialValue: _portfolioTextController.text,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty.';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    /// Validating the form and then adding the report model to the bloc.
                    if (_formKey.currentState!.validate()) {
                      final employeeProfileViewBloc =
                          BlocProvider.of<EmployeeProfileViewBloc>(context);
                      employeeProfileViewBloc.add(
                        ReportAccount(
                          reportModel: ReportModel(
                            comment: _commentController.text.trim(),
                            reason: _reasonForReportController.text.trim(),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );

            /// Showing the dialog.
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return _reportDialog;
              },
            );
          }
        },
      ),
    ],
  );
}

/// _body() is a function that returns a widget. It takes in two required parameters: context and
/// profileModel.
///
/// Args:
///   context: BuildContext
///   profileModel (ProfileModel): ProfileModel(
///
/// Returns:
///   A widget.
Widget _body({required context, required ProfileModel profileModel}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// Calling the _profilePicture method and passing the profileModel.profilePicture as a
        /// parameter.
        _profilePicture(
          profilePicture: profileModel.profilePicture,
        ),

        /// Calling the _fullName method and passing in the fullName and verified properties from the
        /// profileModel.
        _fullName(
          fullName: profileModel.fullName,
          verified: profileModel.verified,
        ),

        /// Calling the _location method and passing the location variable from the profileModel.
        _location(
          location: profileModel.location,
        ),
        SizedBox(height: 5),

        /// Calling the _information method and passing the email and phoneNumber as parameters.
        _information(
          email: profileModel.email,
          phoneNumber: profileModel.phoneNumber,
        ),
        SizedBox(height: 5),

        /// Calling a function called _previousExperience and passing in two parameters.
        _previousExperience(
          context: context,
          previousExperience: profileModel.previousExperience,
        ),
        SizedBox(height: 5),

        /// Calling a function called _educationalBackground and passing in two parameters.
        _educationalBackground(
          educationalBackground: profileModel.educationalBackground,
          context: context,
        ),
        SizedBox(height: 5),

        /// Calling the function _referenceSection() and passing the context as a parameter.
        _referenceSection(
          context: context,
        ),
      ],
    ),
  );
}

/// _profilePicture() is a function that returns a widget that displays a profile picture.
///
/// Args:
///   profilePicture (String): String
///
/// Returns:
///   A widget.
Widget _profilePicture({required String profilePicture}) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.indigo,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60,
        backgroundImage: AssetImage("assets/profile_picture_placeholder.png"),
      ),
    ),
  );
}

/// _fullName() is a function that takes two required parameters, fullName and verified, and returns a
/// Row widget that contains a Container widget that contains a Text widget and a SizedBox widget, and a
/// Container widget or an Icon widget, depending on the value of the verified parameter
///
/// Args:
///   fullName (String): The user's full name.
///   verified (bool): bool
///
/// Returns:
///   A function that returns a widget.
Widget _fullName({required String fullName, required bool verified}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          '$fullName',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      SizedBox(width: 3),
      (() {
        if (verified == true) {
          return Icon(Icons.verified);
        } else {
          return Container();
        }
      }()),
    ],
  );
}

/// _location() is a function that returns a Row widget that contains an Icon widget and a Text widget
///
/// Args:
///   location (String): The location of the event.
///
/// Returns:
///   A widget.
Widget _location({required String location}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.location_on),
      SizedBox(width: 7),
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          '$location',
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ),
    ],
  );
}

/// _information() is a function that takes in two required parameters, email and phoneNumber, and
/// returns a Column widget that contains a Row widget and two Container widgets.
///
/// Args:
///   email (String): String
///   phoneNumber (String): String
///
/// Returns:
///   A Column widget with two ListTile widgets inside of it.
Widget _information({required String email, required String phoneNumber}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Information",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: Icon(Icons.email),
          title: Text("$email"),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: Icon(Icons.phone),
          title: Text("$phoneNumber"),
        ),
      ),
    ],
  );
}

/// It takes a list of maps, and for each map, it creates a widget
///
/// Args:
///   context: BuildContext
///   previousExperience (List): List of previous experience
///
/// Returns:
///   A Column widget with a Container widget and a Container widget as its children.
Widget _previousExperience(
    {required context, required List previousExperience}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Previous Experience',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: previousExperience.map(
            (value) {
              return _previousExperienceTile(
                previousExperienceModel: PreviousExperienceModel(
                  organizationName: value["organizationName"],
                  position: value['position'],
                  duration: value['duration'],
                  dateStarted: value['dateStarted'],
                ),
              );
            },
          ).toList(),
        ),
      ),
    ],
  );
}

/// _previousExperienceTile is a function that takes a required parameter of type
/// PreviousExperienceModel and returns a Widget of type Container
///
/// Args:
///   previousExperienceModel (PreviousExperienceModel): This is the model that contains the data for
/// the previous experience.
///
/// Returns:
///   A widget.
Widget _previousExperienceTile(
    {required PreviousExperienceModel previousExperienceModel}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 7),
    child: ListTile(
      title: Text('${previousExperienceModel.organizationName}'),
      trailing: Text('${previousExperienceModel.position}'),
      subtitle: Text(
          'For ${previousExperienceModel.duration}\nDate Started: ${previousExperienceModel.dateStarted}'),
    ),
  );
}

/// _educationalBackgroundTile is a function that takes in 5 parameters and returns a widget
///
/// Args:
///   educationalBackground (List): [{institution: '', startedDate: '', endDate: '', fieldOfStudy: '',
/// educationLevel: ''}]
///   context: BuildContext
///
/// Returns:
///   A list of widgets.
Widget _educationalBackground({
  required List educationalBackground,
  required context,
}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Educational Background',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: educationalBackground.map(
            (value) {
              return _educationalBackgroundTile(
                institution: value["institution"],
                startedDate: value["startedDate"],
                endDate: value["endDate"],
                fieldOfStudy: value["fieldOfStudy"],
                educationLevel: value["educationLevel"],
              );
            },
          ).toList(),
        ),
      ),
    ],
  );
}

/// _educationalBackgroundTile is a function that returns a Container widget that contains a ListTile
/// widget
///
/// Args:
///   institution (String): The name of the institution
///   startedDate (String): 'Jan 2019',
///   endDate (String): "2020-01-01"
///   fieldOfStudy (String): The field of study of the education.
///   educationLevel (String): "Bachelor's Degree"
///
/// Returns:
///   A Container widget with a ListTile widget as its child.
Widget _educationalBackgroundTile({
  required String institution,
  required String startedDate,
  required String endDate,
  required String fieldOfStudy,
  required String educationLevel,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 7),
    child: ListTile(
      title: Text('$institution'),
      trailing: Text('$educationLevel\n$fieldOfStudy'),
      subtitle: Text('From $startedDate - $endDate'),
    ),
  );
}

/// _referenceSection() is a function that returns a Column widget that contains a Container widget that
/// contains a Row widget that contains a Text widget
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Column widget with two children.
Widget _referenceSection({required context}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'References',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // children: educationalBackground.map(
          //   (value) {

          //     return _referencesTile(
          //       institution: 'value["institution"]',
          //       startedDate: 'value["startedDate"]',
          //       endDate: 'value["endDate"]',
          //       fieldOfStudy: 'value["fieldOfStudy"]',
          //       educationLevel: 'value["educationLevel"]',
          //     );
          //   },
          // ).toList(),
        ),
      ),
    ],
  );
}

/// _referencesTile is a function that takes in 5 required parameters and returns a Container widget
/// with a ListTile child
///
/// Args:
///   institution (String): The name of the institution
///   startedDate (String): String
///   endDate (String): "Present"
///   fieldOfStudy (String): The field of study of the education.
///   educationLevel (String): String,
///
/// Returns:
///   A Container widget with a ListTile widget as a child.
// ignore: unused_element
Widget _referencesTile({
  required String institution,
  required String startedDate,
  required String endDate,
  required String fieldOfStudy,
  required String educationLevel,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 7),
    child: ListTile(
      title: Text('$institution'),
      trailing: Text('$educationLevel\n$fieldOfStudy'),
      subtitle: Text('From $startedDate - To $endDate'),
    ),
  );
}
