import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      drawer: _drawer(context),
    );
  }
}

PreferredSizeWidget _appBar(context) {
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
        onSelected: (clicked) {
          if (clicked == 'Change Profile Picture') {}
          if (clicked == 'Resume Builder') {}
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

Widget _drawer(context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              CircleAvatar(
                minRadius: 50,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/google.jpg',
                  width: 100,
                ),
              ),
              Text(
                'User',
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Account'),
          onTap: () {
            Navigator.of(context).pushNamed('/profile_screen');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text('Bookmarks'),
          onTap: () {
            Navigator.of(context).pushNamed('/bookmarks');
          },
        ),
        Expanded(
          child: Container(),
        ),
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ],
    ),
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
        _uploadCV(),
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

Widget _uploadCV() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 7,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upload CV',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _chooseFile();
          },
          child: Text('Browse'),
        ),
      ],
    ),
  );
}

Future _chooseFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    File file = File(result.files.single.name);
    return file;
  } else {
    // User canceled the picker
  }
}
