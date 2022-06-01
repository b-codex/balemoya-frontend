import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/job/create_job_post/bloc/create_job_post_bloc.dart';
import 'package:balemoya/job/create_job_post/models/models.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CreateJobPost extends StatelessWidget {
  const CreateJobPost({Key? key}) : super(key: key);
  static const routeName = '/create_job_post';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      // drawer: drawer(
      //   context: context,
      //   pageName: routeName,
      //   fullName: "",
      //   profilePicture: "",
      // ),
    );
  }
}

PreferredSizeWidget _appBar(context) {
  return AppBar(
    title: Text("Create Job Post"),
    centerTitle: true,
    actions: [],
  );
}

Widget _body(context) {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _shortDescriptionController = TextEditingController();
  TextEditingController _requirementsController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _tagController = TextEditingController();
  TextEditingController _companySizeController = TextEditingController();

  // get today's time
  var date = new DateTime.now();
  var formatter = new DateFormat('MM-dd-yyyy');
  // ignore: unused_local_variable
  var formattedDate = formatter.format(date);

  return BlocConsumer<CreateJobPostBloc, CreateJobPostState>(
    listener: (context, state) {
      if (state is JobPostCreated) {
        animatedSnackBar(
          context: context,
          message: "Job Post Created.",
          animatedSnackBarType: AnimatedSnackBarType.success,
        );
      }

      if (state is JobPostNotCreated) {
        animatedSnackBar(
          context: context,
          message: "Task Failed. Please Try Again.",
          animatedSnackBarType: AnimatedSnackBarType.error,
        );
      }
    },
    builder: (context, state) {
      var _jobTypes = ['Contractual', 'Permanent', 'One-time'];
      String _selectedJobType = _jobTypes[0];

      return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _companyName(_companyNameController),
              _jobTitle(_jobTitleController),
              _location(_locationController),
              _salary(_salaryController),
              _shortDescription(_shortDescriptionController),
              _requirements(_requirementsController),
              _qualification(_qualificationController),
              _tag(_tagController),
              _companySize(_companySizeController),
              Container(
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
                        _selectedJobType = newValue!;
                      },
                    ),
                  ],
                ),
              ),
              CompanyLogo.returnWidget(),
              Container(
                margin: EdgeInsets.only(
                  top: 35,
                ),
                child: BlocBuilder<CreateJobPostBloc, CreateJobPostState>(
                  builder: (context, state) {
                    
                    if (state is CreatingPost) {
                      return ElevatedButton(
                        onPressed: null,
                        child: loading(),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(400, 50),
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final bloc =
                              BlocProvider.of<CreateJobPostBloc>(context);
                          bloc.add(
                            CreateAJobPostEvent(
                              createJobPostModel: CreateJobPostModel(
                                companyName: _companyNameController.text.trim(),
                                jobTitle: _jobTitleController.text.trim(),
                                location: _locationController.text.trim(),
                                salary: _salaryController.text.trim(),
                                shortDescription:
                                    _shortDescriptionController.text.trim(),
                                requirements:
                                    _requirementsController.text.trim(),
                                qualification:
                                    _qualificationController.text.trim(),
                                tag: _tagController.text.trim(),
                                companySize: _companySizeController.text.trim(),
                                jobType: _selectedJobType,
                                companyLogo: CompanyLogo.getFile(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text("Post"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400, 50),
                      ),
                    );
                  },
                ),
              ),
              _helpText(),
            ],
          ),
        ),
      );
    },
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

Widget _jobTitle(_jobTitleController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: _formField(
      _jobTitleController,
      "Job Title",
    ),
  );
}

Widget _qualification(_qualificationController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: _formField(
      _qualificationController,
      "Qualification",
    ),
  );
}

Widget _tag(_tagController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: _formField(
      _tagController,
      "Tag",
    ),
  );
}

Widget _companySize(_companySizeController) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    child: _formField(
      _companySizeController,
      "Company Size",
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
      // keyboardType: TextInputType.multiline,
      // maxLines: null,
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
        // 
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
      // maxLines: null,
      decoration: InputDecoration(
        label: Text("Requirements"),
        // prefixIcon: _prefixIcon,
        helperText: 'Enter each requirement separated in a comma',
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
        // 
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

class CompanyLogo {
  static late String file = "";

  static getFile() {
    return file;
  }

  static returnWidget() {
    String filePath = "";
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 7.0,
        vertical: 7.0,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload Company Logo (Optional)',
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        _uploadLogo().then((value) {
                          var data = value as Map;

                          setState(
                            () {
                              file = data['fileName'];
                              filePath = data['filePath'];
                            },
                          );
                        });
                      },
                      child: Text('Select Logo'),
                    ),
                  ),
                ],
              ),
              (() {
                if (filePath != "") {
                  return Container(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.file(
                        File(filePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                return SizedBox();
              }()),
            ],
          );
        },
      ),
    );
  }
}

Future<Object> _uploadLogo() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (result != null) {
    final String filePath = result.files.single.path.toString();
    final String fileName = result.files.single.name.toString();
    return {
      'filePath': filePath,
      'fileName': fileName,
      'chosen': true,
    };
  } else {
    // User canceled the picker
    return {
      'chosen': false,
    };
  }
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

Widget loading() {
  return const LoadingIndicator(
      indicatorType: Indicator.ballPulseSync,

      /// Required, The loading type of the widget
      colors: [Colors.indigo],

      /// Optional, The color collections
      strokeWidth: 2,

      /// Optional, The stroke of the line, only applicable to widget which contains line
      backgroundColor: Colors.transparent,

      /// Optional, Background of the widget
      pathBackgroundColor: Colors.transparent

      /// Optional, the stroke backgroundColor
      );
}
