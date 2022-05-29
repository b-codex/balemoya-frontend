import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/account/profile/models/models.dart';
import 'package:balemoya/static/widgets/date_picker.dart';
import 'package:balemoya/static/widgets/drawer.dart';
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

        if (state is ProfileLoadingFailed) {
          animatedSnackBar(
            context: context,
            message: 'An Error Occurred. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home_screen', (route) => false);
        }

        if (state is ChangeProfilePictureFailed) {
          animatedSnackBar(
            context: context,
            message: 'An Error Occurred. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        if (state is ChangeProfilePictureSuccess) {
          animatedSnackBar(
            context: context,
            message: 'Profile Picture Changed.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        if (state is PreviousExperienceAdded) {
          animatedSnackBar(
            context: context,
            message: 'Previous Experience Added.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        if (state is PreviousExperienceAddingFailed) {
          animatedSnackBar(
            context: context,
            message: 'Task Failed. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
          // bloc.add(LoadProfileEvent());
        }

        if (state is EducationalBackgroundAdded) {
          animatedSnackBar(
            context: context,
            message: 'Educational Background Added.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        if (state is EducationalBackgroundAddingFailed) {
          animatedSnackBar(
            context: context,
            message: 'Task Failed. Please Try Again.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
          // bloc.add(LoadProfileEvent());
        }

        if (state is UploadCVSuccess) {
          animatedSnackBar(
            context: context,
            message: 'CV Uploaded.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
        }

        if (state is UploadCVFailed) {
          animatedSnackBar(
            context: context,
            message: 'CV Upload Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        if (state is PortfolioUpdateSuccess) {
          animatedSnackBar(
            context: context,
            message: 'Portfolio Update Success.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        if (state is PortfolioUpdateFailed) {
          animatedSnackBar(
            context: context,
            message: 'Portfolio Update Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        if (state is SkillsUpdateSuccess) {
          animatedSnackBar(
            context: context,
            message: 'Skills Update Success.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          bloc.add(LoadProfileEvent());
        }

        if (state is SkillsUpdateFailed) {
          animatedSnackBar(
            context: context,
            message: 'Skills Update Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }

        if (state is DeleteAccountSuccess) {
          animatedSnackBar(
            context: context,
            message: 'Account Deletion Success.',
            animatedSnackBarType: AnimatedSnackBarType.success,
          );
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }

        if (state is DeleteAccountFailed) {
          animatedSnackBar(
            context: context,
            message: 'Account Deletion Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileInitial) {
          bloc.add(LoadProfileEvent());
        }

        if (state is LoadingProfile) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ProfileLoadDone) {
          return Scaffold(
            appBar: _appBar(context),
            body: _body(context: context, profileModel: state.profileModel),
            drawer: drawer(context: context, pageName: "profile"),
          );
        }
        // if (state is ProfileLoadingFailed) {
        // }
        return Scaffold();
      },
    );
  }
}

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

          if (clicked == 'Request Verification') {}

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
            context: context),
      ],
    ),
  );
}

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

Widget _skill(skillText) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 7),
    child: ListTile(
      leading: Icon(Icons.check),
      title: Text('$skillText'),
    ),
  );
}

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
              print(value);
              print(value.runtimeType);
              return _educationalBackgroundTile(
                institution: 'value["institution"]',
                startedDate: 'value["startedDate"]',
                endDate: 'value["endDate"]',
                fieldOfStudy: 'value["fieldOfStudy"]',
                educationLevel: 'value["educationLevel"]',
              );
            },
          ).toList(),
        ),
      ),
    ],
  );
}

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
      subtitle: Text('From $startedDate - To $endDate'),
    ),
  );
}
