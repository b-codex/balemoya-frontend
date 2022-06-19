import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/job/create_job_post/bloc/create_job_post_bloc.dart';
import 'package:balemoya/job/create_job_post/models/models.dart';
import 'package:balemoya/job/home/bloc/home_bloc.dart';
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
      body: FormBody(),
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

class FormBody extends StatefulWidget {
  const FormBody({Key? key}) : super(key: key);

  @override
  State<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  var _jobTypes = ['Contractual', 'Full-time', 'One-time'];
  String _selectedJobType = 'Contractual';
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

  @override
  Widget build(BuildContext context) {
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
          final JobBloc = BlocProvider.of<HomeBloc>(context);
          JobBloc.add(GetJobPosts());
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
                        value: _selectedJobType,
                        hint: Text("Select Job Type"),
                        items: _jobTypes.map(
                          (_jobType) {
                            return DropdownMenuItem(
                              child: Text(_jobType),
                              value: _jobType,
                            );
                          },
                        ).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedJobType = newValue!;
                          });
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
                                  companyName:
                                      _companyNameController.text.trim(),
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
                                  companySize:
                                      _companySizeController.text.trim(),
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
}

/// _companyName is a function that returns a Container widget that contains a _formField widget.
///
/// Args:
///   _companyNameController: TextEditingController
///
/// Returns:
///   A Container widget with a child of a FormField widget.
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

/// _jobTitle is a function that returns a Container widget that contains a _formField widget.
///
/// Args:
///   _jobTitleController: TextEditingController
///
/// Returns:
///   A Container widget with a margin and a child.
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

/// _qualification() is a function that returns a Container widget that contains a _formField() widget.
///
/// Args:
///   _qualificationController: TextEditingController
///
/// Returns:
///   A Container widget with a child of a _formField widget.
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

/// _tag() is a function that returns a Container widget that contains a _formField() widget.
///
/// Args:
///   _tagController: TextEditingController
///
/// Returns:
///   A Container widget with a child of a _formField widget.
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

/// _companySize is a function that returns a Container widget that contains a _formField widget.
///
/// Args:
///   _companySizeController: TextEditingController
///
/// Returns:
///   A Container widget with a child of a _formField widget.
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

/// _location is a function that takes a controller as an argument and returns a widget.
///
/// Args:
///   _locationController: TextEditingController
///
/// Returns:
///   A Container widget with a child of a _formField widget.
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

/// _salary is a function that takes a TextEditingController as an argument and returns a Container
/// widget.
///
/// Args:
///   _salaryController: TextEditingController
///
/// Returns:
///   A Container widget with a child of a _formField widget.
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

/// _shortDescription() is a function that returns a widget
///
/// Args:
///   _shortDescriptionController: TextEditingController
///
/// Returns:
///   A Container widget with a TextFormField widget as a child.
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

/// _requirements() is a function that returns a widget
///
/// Args:
///   _requirementsController: TextEditingController
///
/// Returns:
///   A Container widget with a TextFormField widget inside of it.
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

/// _helpText() returns a Container widget that contains a Text widget
///
/// Returns:
///   A Container widget with a Text widget inside of it.
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

  /// It returns the file object
  ///
  /// Returns:
  ///   The file variable is being returned.
  static getFile() {
    return file;
  }

  /// The function returns a Container widget. The Container widget has a margin of
  /// EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0). The Container widget has a StatefulBuilder
  /// widget as a child. The StatefulBuilder widget has a builder parameter. The builder parameter is a
  /// function that takes in a BuildContext and a setState function. The builder function returns a Column
  /// widget. The Column widget has a Row widget as a child. The Row widget has a mainAxisAlignment of
  /// MainAxisAlignment.spaceBetween. The Row widget has two children. The first child is a Text widget.
  /// The Text widget has a text of 'Upload Company Logo (Optional)'. The second child is a Container
  /// widget. The Container widget has an ElevatedButton widget as a child. The ElevatedButton widget has
  /// an onPressed parameter. The onPressed parameter is a function that calls the _uploadLogo function.
  /// The _uploadLogo
  ///
  /// Returns:
  ///   A StatefulBuilder widget.
  static returnWidget() {
    String filePath = "";
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 7.0,
        vertical: 7.0,
      ),

      /// The code below is creating a StatefulBuilder widget. The StatefulBuilder widget has a
      /// builder parameter. The builder parameter is a function that takes in a BuildContext and
      /// a setState function. The builder function returns a Column widget. The Column widget
      /// has a Row widget as a child. The Row widget has a mainAxisAlignment of
      /// MainAxisAlignment.spaceBetween. The Row widget has two children. The first child is a
      /// Text widget. The Text widget has a text of 'Upload Company Logo (Optional)'. The second
      /// child is a Container widget. The Container widget has
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

              /// Checking if the filePath is not empty, if it is not empty, it will return a Container with a height
              /// of 150 and a width of 150. The Container will have a ClipRRect widget as a child. The ClipRRect
              /// widget will have a borderRadius of 80. The ClipRRect widget will have an Image.file widget as a
              /// child. The Image.file widget will have a File widget as a child. The File widget will have the
              /// filePath as a parameter. The Image.file widget will have a fit of BoxFit.cover. If the file
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

/// It opens the file picker and returns the file path and file name.
///
/// Returns:
///   A Future<Object>
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

/// This function takes in two parameters, a controller and a form label. It returns a TextFormField
/// widget with the controller and label passed in as parameters.
///
/// Args:
///   _controller: TextEditingController
///   _formLabel: The label of the form field.
///
/// Returns:
///   A TextFormField widget.
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

/// This function returns a widget that displays a loading indicator.
///
/// Returns:
///   A widget that is a loading indicator.
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
