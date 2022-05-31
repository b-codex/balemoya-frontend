import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/account/profile/models/models.dart';
import 'package:balemoya/static/widgets/date_picker.dart';
import 'package:balemoya/static/widgets/duration_picker.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile_screen';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        print(state);

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

        /// Checking if the state is ChangeProfilePictureFailed, if it is, it will show an error
        /// message.
        if (state is ChangeProfilePictureFailed) {
          animatedSnackBar(
            context: context,
            message: 'An Error Occurred. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        /// Showing a snackbar with a message and then loading the profile again.
        if (state is ChangeProfilePictureSuccess) {
          animatedSnackBar(
            context: context,
            message: 'Profile Picture Changed.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        /// Checking if the state is PreviousExperienceAdded, if it is, it will show a snackbar with the
        /// message 'Previous Experience Added.' and then it will load the profile again.
        if (state is PreviousExperienceAdded) {
          animatedSnackBar(
            context: context,
            message: 'Previous Experience Added.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        /// Checking if the state is PreviousExperienceAddingFailed, if it is, it will show a snackbar
        /// with the message 'Task Failed. Please Try Again.'
        if (state is PreviousExperienceAddingFailed) {
          animatedSnackBar(
            context: context,
            message: 'Task Failed. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
          // bloc.add(LoadProfileEvent());
        }

        /// Checking if the state is EducationalBackgroundAdded, if it is, it will show a snackbar with
        /// the message "Educational Background Added." and it will also call the LoadProfileEvent() to
        /// refresh the data.
        if (state is EducationalBackgroundAdded) {
          animatedSnackBar(
            context: context,
            message: 'Educational Background Added.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        /// Checking if the state is EducationalBackgroundAddingFailed, if it is, it will show a
        /// snackbar with the message "Task Failed. Please Try Again."
        if (state is EducationalBackgroundAddingFailed) {
          animatedSnackBar(
            context: context,
            message: 'Task Failed. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
          // bloc.add(LoadProfileEvent());
        }

        /// Checking if the state is UploadCVSuccess, if it is, it will show a snackbar with the message
        /// 'CV Uploaded.'
        if (state is UploadCVSuccess) {
          animatedSnackBar(
            context: context,
            message: 'CV Uploaded.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
        }

        /// Checking if the state is UploadCVFailed, if it is, it will show an error message.
        if (state is UploadCVFailed) {
          animatedSnackBar(
            context: context,
            message: 'CV Upload Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        /// Checking if the state is PortfolioUpdateSuccess, if it is, it will show a snackbar with the
        /// message "Portfolio Update Success" and then it will call the LoadProfileEvent.
        if (state is PortfolioUpdateSuccess) {
          animatedSnackBar(
            context: context,
            message: 'Portfolio Update Success.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        /// Checking if the state is PortfolioUpdateFailed, if it is, it will show a snackbar with the
        /// message 'Portfolio Update Failed.'
        if (state is PortfolioUpdateFailed) {
          animatedSnackBar(
            context: context,
            message: 'Portfolio Update Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        /// Checking if the state is DeleteAccountSuccess, if it is, it will show a snackbar with the
        /// message "Account Deletion Success." and then it will navigate to the root page and remove
        /// all the routes.
        if (state is DeleteAccountSuccess) {
          animatedSnackBar(
            context: context,
            message: 'Account Deletion Success.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }

        /// Checking if the state is DeleteAccountFailed, if it is, it will show an error message.
        if (state is DeleteAccountFailed) {
          animatedSnackBar(
            context: context,
            message: 'Account Deletion Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        /// Checking if the state is VerificationRequestSuccess, if it is, it will show a snackbar.
        if (state is VerificationRequestSuccess) {
          animatedSnackBar(
            context: context,
            message:
                'Verification Request Sent To Admin. An Email Will Be Sent As Confirmation.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
        }

        /// Checking if the state is VerificationRequestFailed, if it is, it will show a snackbar with
        /// the message "Task Failed. Please Try Again."
        if (state is VerificationRequestFailed) {
          animatedSnackBar(
            context: context,
            message: 'Task Failed. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        if (state is ReferenceAdded) {
          animatedSnackBar(
            context: context,
            message: "Reference Added.",
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }
        if (state is ReferenceNotAdded) {
          animatedSnackBar(
            context: context,
            message: "Reference Not Added.",
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
          // bloc.add(LoadProfileEvent());
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
            // drawer: drawer(context: context, pageName: "profile"),
          );
        }
        // if (state is ProfileLoadingFailed) {
        // }
        return Scaffold(
          appBar: AppBar(),
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
  final profileBloc = BlocProvider.of<ProfileBloc>(context);
  return AppBar(
    actions: [
      PopupMenuButton(
        child: Icon(Icons.more_vert),
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              value: 'Change Profile Picture',
              child: Text(
                'Change Profile Picture',
                style: TextStyle(color: Colors.black),
              ),
            ),
            PopupMenuItem(
              value: 'Upload CV',
              child: Text(
                'Upload CV',
                style: TextStyle(color: Colors.black),
              ),
            ),
            PopupMenuItem(
              value: 'Resume Builder',
              child: Text(
                'Resume Builder',
                style: TextStyle(color: Colors.black),
              ),
            ),
            PopupMenuItem(
              value: 'Request Verification',
              child: Text(
                'Request Verification',
                style: TextStyle(color: Colors.black),
              ),
            ),
            PopupMenuItem(
              value: 'Reset Password',
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.black),
              ),
            ),
            PopupMenuItem(
              value: 'Delete Account',
              child: Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ];
        },
        onSelected: (clicked) async {
          if (clicked == 'Change Profile Picture') {
            final _filePath = await _changeProfilePicture().then(
              (value) {
                return value as Map;
              },
            );

            if (_filePath['chosen'] == true) {
              profileBloc.add(
                ChangeProfilePictureEvent(
                  filePath: _filePath['filePath'],
                ),
              );
            }
          }

          if (clicked == 'Resume Builder') {}

          if (clicked == 'Upload CV') {
            final _filePath = await _uploadCV().then(
              (value) {
                return value as Map;
              },
            );

            if (_filePath['chosen'] == true) {
              profileBloc.add(
                UploadCVEvent(
                  filePath: _filePath['filePath'],
                ),
              );
            }
          }
          if (clicked == 'Reset Password') {
            Navigator.of(context).pushNamed('/reset_password');
          }

          if (clicked == 'Request Verification') {
            animatedSnackBar(
              context: context,
              message:
                  "Please Upload A PDF File Containing Your ID Card, Resume and Other Necessary Documents.",
              animatedSnackBarType: AnimatedSnackBarType.info,
            );
            await Future.delayed(
              Duration(
                seconds: 3,
              ),
            );
            final _filePath = await _uploadVerificationDocument().then(
              (value) {
                return value as Map;
              },
            );
            // print(_filePath);
            // print(_filePath["filePath"]);
            profileBloc.add(
              GetVerifiedEvent(
                filePath: _filePath["filePath"],
              ),
            );
          }

          if (clicked == 'Delete Account') {
            var _alertDialog = AlertDialog(
              title: Text('Confirm'),
              content: Text('Are you sure you want to delete your account?'),
              actions: [
                TextButton(
                  onPressed: () {
                    profileBloc.add(DeleteAccountEvent());
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return _alertDialog;
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
        _profilePicture(profilePicture: profileModel.profilePicture),
        _fullName(
            fullName: profileModel.fullName, verified: profileModel.verified),
        _location(location: profileModel.location),
        _information(
            email: profileModel.email, phoneNumber: profileModel.phoneNumber),
        _portfolio(context, profileModel.portfolio),
        // _uploadCV(),
        _previousExperience(
          context: context,
          previousExperience: profileModel.previousExperience,
        ),
        _educationalBackground(
          educationalBackground: profileModel.educationalBackground,
          context: context,
        ),
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

/// It's a function that returns a widget
///
/// Args:
///   context: BuildContext
///   portfolioText: This is the text that is to be displayed in the Text widget.
///
/// Returns:
///   A Column widget with a Container widget and a Row widget as its children.
Widget _portfolio(
  context,
  portfolioText,
) {
  final profileBloc = BlocProvider.of<ProfileBloc>(context);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Portfolio',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                final _formKey = GlobalKey<FormState>();
                final TextEditingController _portfolioTextController =
                    TextEditingController();
                _portfolioTextController.text = portfolioText;

                var _editPortfolioDialog = AlertDialog(
                  title: Text('Edit Portfolio'),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _portfolioTextController,
                      decoration: InputDecoration(
                        label: Text("Edit Portfolio"),
                        prefixIcon: Icon(Icons.edit),
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
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          profileBloc.add(
                            EditPortfolioEvent(
                              editedText: _portfolioTextController.text,
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Update',
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
                    return _editPortfolioDialog;
                  },
                );
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 7,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$portfolioText',
                overflow: TextOverflow.clip,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

/// _uploadCV() is a function that allows the user to pick a file from their device and returns the file
/// path of the chosen file
///
/// Returns:
///   A Future<Object>
Future<Object> _uploadCV() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    allowMultiple: false,
  );

  if (result != null) {
    final String filePath = result.files.single.path.toString();
    return {
      'filePath': filePath,
      'chosen': true,
    };
  } else {
    // User canceled the picker
    return {
      'chosen': false,
    };
  }
}

/// It opens the file picker, and if the user chooses a file, it returns the file path
///
/// Returns:
///   A Future<Object>
Future<Object> _changeProfilePicture() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (result != null) {
    final String filePath = result.files.single.path.toString();
    return {
      'filePath': filePath,
      'chosen': true,
    };
  } else {
    // User canceled the picker
    return {
      'chosen': false,
    };
  }
}

Widget _previousExperience(
    {required context, required List previousExperience}) {
  final profileBloc = BlocProvider.of<ProfileBloc>(context);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _positionController = TextEditingController();
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
            IconButton(
              onPressed: () {
                final AlertDialog _addPreviousExperience = AlertDialog(
                  title: Text('Where have you worked before?'),
                  content: Form(
                    key: _formKey,
                    child: SizedBox(
                      // height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _organizationNameController,
                            decoration: InputDecoration(
                              label: Text("Organization Name"),
                              hintText: "Noob-Dev",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            maxLines: null,
                            // keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field can\'t be empty.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 9),
                          TextFormField(
                            controller: _positionController,
                            decoration: InputDecoration(
                              label: Text("Position"),
                              hintText: "Manager",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            maxLines: null,
                            // keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field can\'t be empty.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 9),
                          DurationPicker.returnWidget(),
                          SizedBox(height: 9),
                          DatePicker.returnStartedDateWidget(),
                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          profileBloc.add(
                            AddPreviousExperience(
                              previousExperienceModel: PreviousExperienceModel(
                                organizationName:
                                    _organizationNameController.text.trim(),
                                position: _positionController.text.trim(),
                                duration: "${DurationPicker.getValue()}+ years",
                                dateStarted: DatePicker.getStartedDate(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Add',
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

                showDialog(
                  context: context,
                  builder: (_) {
                    return _addPreviousExperience;
                  },
                );
              },
              icon: Icon(Icons.add),
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
  final profileBloc = BlocProvider.of<ProfileBloc>(context);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _educationLevelController =
      TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
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
            IconButton(
              onPressed: () {
                final AlertDialog _addPreviousExperience = AlertDialog(
                  title: Text('Add an institution...'),
                  content: Form(
                    key: _formKey,
                    child: SizedBox(
                      // height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _institutionController,
                            decoration: InputDecoration(
                              label: Text("Institution"),
                              hintText: "Addis Ababa institute of Technology",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            maxLines: null,
                            // keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field can\'t be empty.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 9),
                          TextFormField(
                            controller: _educationLevelController,
                            decoration: InputDecoration(
                              label: Text("Education Level"),
                              hintText: "Bachelor's Degree",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            maxLines: null,
                            // keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field can\'t be empty.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 9),
                          TextFormField(
                            controller: _fieldOfStudyController,
                            decoration: InputDecoration(
                              label: Text("Field of Study"),
                              hintText: "Information Technology",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            maxLines: null,
                            // keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field can\'t be empty.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 9),
                          DatePicker.returnStartedDateWidget(),
                          SizedBox(height: 9),
                          DatePicker.returnEndDateWidget(),
                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          profileBloc.add(
                            AddEducationalBackground(
                              educationModel: EducationModel(
                                institution: _institutionController.text.trim(),
                                educationLevel:
                                    _educationLevelController.text.trim(),
                                fieldOfStudy:
                                    _fieldOfStudyController.text.trim(),
                                startedDate: DatePicker.getStartedDate(),
                                endDate: DatePicker.getEndDate(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Add',
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

                showDialog(
                  context: context,
                  builder: (_) {
                    return _addPreviousExperience;
                  },
                );
              },
              icon: Icon(Icons.add),
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
              // print(value);
              // print(value.runtimeType);
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

/// _uploadVerificationDocument() is a function that allows the user to select a file from their device,
/// and returns the file path of the selected file
///
/// Returns:
///   A Future<Object>
Future<Object> _uploadVerificationDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    allowMultiple: false,
  );

  if (result != null) {
    final String filePath = result.files.single.path.toString();
    return {
      'filePath': filePath,
      'chosen': true,
    };
  } else {
    // User canceled the picker
    return {
      'chosen': false,
    };
  }
}

Widget _referenceSection({
  required context,
}) {
  final profileBloc = BlocProvider.of<ProfileBloc>(context);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

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
            IconButton(
              onPressed: () {
                final AlertDialog _addReference = AlertDialog(
                  title: Text('Add your reference...'),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            label: Text("Fullname"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          // maxLines: null,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field can\'t be empty.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 9),
                        TextFormField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            label: Text("Phone Number"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          // maxLines: null,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field can\'t be empty.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 9),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          profileBloc.add(
                            AddReferenceEvent(
                              fullName: _fullNameController.text.trim(),
                              phoneNumber: _phoneNumberController.text.trim(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Add',
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

                showDialog(
                  context: context,
                  builder: (_) {
                    return _addReference;
                  },
                );
              },
              icon: Icon(Icons.add),
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
          //     // print(value);
          //     // print(value.runtimeType);
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
