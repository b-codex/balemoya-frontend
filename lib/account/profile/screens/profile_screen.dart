import 'dart:io';

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
      },
      builder: (context, state) {
        if (state is ProfileInitial) {
          bloc.add(
            LoadProfileEvent(),
          );
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
          drawer: drawer(context),
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
            final String _filePath = await _changeProfilePicture().then(
              (value) {
                return value;
              },
            );
            profileBloc.add(
              ChangeProfilePictureEvent(
                filePath: _filePath,
              ),
            );
          }
          if (clicked == 'Resume Builder') {}
          if (clicked == 'Upload CV') {
            _chooseCV();
          }
          if (clicked == 'Reset Password') {
            Navigator.of(context).pushNamed('/reset_password');
          }
          if (clicked == 'Delete Account') {
            var _alertDialog = AlertDialog(
              title: Text('Confirm'),
              content: Text('Are you sure you want to delete your account?'),
              actions: [
                TextButton(
                  onPressed: () {},
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
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _profilePicture(),
        _name(),
        _location(),
        _portfolio(),
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

Widget _portfolio() {
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
              onPressed: () {},
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.',
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
              onPressed: () {},
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
          children: [
            _skill(),
            _skill(),
            _skill(),
            _skill(),
            _skill(),
          ],
        ),
      ),
    ],
  );
}

Widget _skill() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 7),
    child: ListTile(
      leading: Icon(Icons.check),
      title: Text('My skill'),
    ),
  );
}

// Widget _uploadCV() {
//   return Container(
//     margin: EdgeInsets.symmetric(
//       horizontal: 15,
//       vertical: 7,
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Upload CV',
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             _chooseCV();
//           },
//           child: Text('Browse'),
//         ),
//       ],
//     ),
//   );
// }

Future _chooseCV() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    allowMultiple: false,
  );

  if (result != null) {
    final String filePath = result.files.single.path.toString();
    return filePath;
  } else {
    // User canceled the picker
  }
}

Future _changeProfilePicture() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (result != null) {
    final String filePath = result.files.single.path.toString();
    return filePath;
  } else {
    // User canceled the picker
  }
}
