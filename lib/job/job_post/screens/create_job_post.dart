import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateJobPost extends StatelessWidget {
  const CreateJobPost({Key? key}) : super(key: key);
  static const routeName = '/create_job_post';

  @override
  Widget build(BuildContext context) {
    TextEditingController _companyNameController = TextEditingController();
    TextEditingController _locationController = TextEditingController();
    TextEditingController _salaryController = TextEditingController();
    TextEditingController _shortDescriptionController = TextEditingController();
    TextEditingController _requirementsController = TextEditingController();

    // get today's time
    var date = new DateTime.now();
    var formatter = new DateFormat('MM-dd-yyyy');
    var formattedDate = formatter.format(date);
    // print(formattedDate);

    var _controllers = [
      _companyNameController,
      _locationController,
      _salaryController,
      _shortDescriptionController,
      _requirementsController,
    ];

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context, _controllers),
      drawer: _drawer(context),
    );
  }
}

PreferredSizeWidget _appBar(context) {
  return AppBar(
    title: Text("Create Job Post"),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          // redirect to profile page
        },
        icon: Image.asset('assets/start_screen.png'),
      )
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
                  'assets/start_screen.png',
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
          onTap: () {},
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

Widget _body(context, _controllers) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _companyName(_controllers[0]),
        _location(_controllers[1]),
        _salary(_controllers[2]),
        _shortDescription(_controllers[3]),
        _requirements(_controllers[4]),
        _jobType(),
        _companyLogo(),
        _postButton(),
        _helpText(),
      ],
    ),
  );
}

Widget _companyName(_companyNameController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: _formField(
      _companyNameController,
      "Company Name",
    ),
  );
}

Widget _location(_locationController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: _formField(
      _locationController,
      "Location",
    ),
  );
}

Widget _jobType() {
  var _jobTypes = ['Contractual', 'Permanent', 'One-time'];
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 7.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Job Type: '),
        DropdownButton(
          value: 'Contractual',
          items: _jobTypes.map(
            (_jobType) {
              return DropdownMenuItem(
                child: Text(_jobType),
                value: _jobType,
              );
            },
          ).toList(),
          onChanged: (String? newValue) {
            print(newValue);
          },
        ),
      ],
    ),
  );
}

Widget _salary(_salaryController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: _formField(
      _salaryController,
      "Salary",
    ),
  );
}

Widget _shortDescription(_shortDescriptionController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: TextFormField(
      controller: _shortDescriptionController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        label: Text("Short Description"),
        // prefixIcon: _prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field can\'t be empty.';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        // print(value);
      },
    ),
  );
}

Widget _requirements(_requirementsController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: TextFormField(
      controller: _requirementsController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        label: Text("Requirements"),
        // prefixIcon: _prefixIcon,
        helperText: 'Enter each requirement in a new line',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field can\'t be empty.';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        // print(value);
      },
    ),
  );
}

Widget _helpText() {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 7.0,
      horizontal: 7.0,
    ),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color.fromARGB(179, 255, 255, 255),
      borderRadius: BorderRadius.circular(17),
    ),
    child: Text(
      'When you click post, today\'s date will automatically be attached to this post.',
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w100,
      ),
    ),
  );
}

Widget _postButton() {
  return Container(
    margin: EdgeInsets.only(
      top: 35,
    ),
    child: ElevatedButton(
      onPressed: () {},
      child: Text("Post"),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(400, 50),
      ),
    ),
  );
}

Widget _companyLogo() {
  Future<File> file;
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upload Company Logo (Optional)',
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              _chooseImage();
            },
            child: Text('Select Logo'),
          ),
        ),
      ],
    ),
  );
}

Future _chooseImage() async {
   final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  print(image.toString());
}

Widget _formField(_controller, _formLabel) {
  return TextFormField(
    controller: _controller,
    decoration: InputDecoration(
      label: Text("$_formLabel"),
      // prefixIcon: _prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field can\'t be empty.';
      } else {
        return null;
      }
    },
  );
}
