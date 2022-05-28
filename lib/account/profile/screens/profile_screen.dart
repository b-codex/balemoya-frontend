import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/static/widgets/drawer.dart';
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
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('/home_screen', (route) => false);
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

        // if (state is ProfileLoadingFailed) {
        //   return Scaffold();
        // }
        return Scaffold(
          appBar: _appBar(context),
          body: _body(context),
          drawer: drawer(context: context, pageName: "profile"),
        );
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

Widget _body(context) {
  String portfolioText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.';

  List<String> skills = ['flutter', 'web development', 'backend development'];
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _profilePicture(),
        _name(),
        _location(),
        _portfolio(context, portfolioText, skills),
        // _uploadCV(),
      ],
    ),
  );
}

Widget _profilePicture() {
  return Center(
    child: Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset(
            'assets/google.jpg',
            height: 90,
          ),
        ),
      ),
    ),
  );
}

Widget _name() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          'Name Here',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    ],
  );
}

Widget _location() {
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
          'Location',
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ),
    ],
  );
}

Widget _portfolio(context, portfolioText, List<String> skills) {
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
              padding: EdgeInsets.all(14),
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
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Skills',
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
                  title: Text('Edit Skills'),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _portfolioTextController,
                      decoration: InputDecoration(
                        label: Text("Edit Skills"),
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
                          //
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
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: skills.map(
            (skillText) {
              return _skill(skillText);
            },
          ).toList(),
        ),
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
