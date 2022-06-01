import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/job/job_detail/bloc/job_detail_bloc.dart';
import 'package:balemoya/job/job_detail/models/model.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetail extends StatelessWidget {
  final Map job;
  const JobDetail({Key? key, required this.job}) : super(key: key);

  /// A static variable that is used to identify the route.
  static const routeName = '/job_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(context, job),
      // bottomSheet: _applyButton(context),
    );
  }
}

/// _body() returns a Column widget that contains a _header() widget and a _tabBar() widget
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Column widget with two children.
Widget _body(context, job) {
  List reviews = [];
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 10),
      _header(context, job),
      // _tabBar(context),
      _req(job),

      _reviewSection(reviews: reviews, role: job['role'], jobID: job['id']),
      _applyButton(context, job),
    ],
  );
}

/// _header() returns a Column widget that contains a Row widget that contains a _profilePicture()
/// widget and a _info() widget, and a _shortDescription() widget.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Column widget with a Row widget and a Text widget as children.
Widget _header(context, job) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // _backButton(context),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _profilePicture(),
          _info(job),
        ],
      ),
      _shortDescription(job),
    ],
  );
}

/// _tabBar() is a function that returns a DefaultTabController widget that contains a Container widget
/// that contains a Column widget that contains a TabBar widget and an Expanded widget that contains a
/// TabBarView widget that contains two widgets: _requirementsList() and _reviewSection()
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A DefaultTabController with a Container with a Column with a TabBar and an Expanded with a
/// TabBarView.
// ignore: unused_element
Widget _tabBar(context) {
  return DefaultTabController(
    length: 2,
    child: Container(
      height: MediaQuery.of(context).size.height * 0.648,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Requirements",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Review",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // 1st tab which contains a list of job requirements
                _requirementsList(),

                // 2nd tab which contains a list of reviews
                // _reviewSection(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// _requirementsList() returns a SizedBox widget that has a height of half the screen height, and a
/// ListView.builder widget as its child. The ListView.builder widget has a scrollDirection of
/// Axis.vertical, and an itemCount of the length of the requirements list. The itemBuilder function
/// returns a Container widget that has a margin of 7 pixels on the vertical axis, and a ListTile widget
/// as its child. The ListTile widget has an Icon widget as its leading widget, and a Text widget as its
/// subtitle widget. The Text widget has a string interpolation of the requirements list at the index of
/// the itemBuilder function
///
/// Returns:
///   A widget that is a sized box with a list view builder.
Widget _requirementsList() {
  final requirements = [
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement9',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
  ];

  return Builder(
    builder: (context) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: requirements.length,
        itemBuilder: ((context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text(
                '${requirements[index]}',
              ),
            ),
          );
        }),
      );
    },
  );
}

Widget _req(job) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: "Requirements: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
                children: [
                  TextSpan(
                    text: '${job["requirements"]}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

/// _applyButton() is a function that returns a Container widget that contains an ElevatedButton widget
/// that has a TextButton widget as its child
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Container widget with a child of an ElevatedButton widget.
Widget _applyButton(context, job) {
  return BlocConsumer<JobDetailBloc, JobDetailState>(
    listener: (context, state) {
      if (state is AppliedToJobPost) {
        animatedSnackBar(
            context: context,
            message: "Application Sent.",
            animatedSnackBarType: AnimatedSnackBarType.success);
      }
      if (state is NotAppliedToJobPost) {
        animatedSnackBar(
          context: context,
          message: "Task Failed. Please Try Again.",
          animatedSnackBarType: AnimatedSnackBarType.error,
        );
      }
    },
    builder: (context, state) {
      if (job["role"] == "employer") {
        return Container();
      }
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 7,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 50),
          ),
          onPressed: () {
            final _formKey = GlobalKey<FormState>();
            final TextEditingController _emailController =
                TextEditingController();
            final TextEditingController _phoneNumberController =
                TextEditingController();
            final TextEditingController _messageController =
                TextEditingController();

            final AlertDialog _addReference = AlertDialog(
              title: Text('Confirm Your Information...'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // maxLines: null,
                        keyboardType: TextInputType.emailAddress,
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
                      TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          label: Text("Message"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // maxLines: null,
                        keyboardType: TextInputType.text,
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
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      final jobDetailBloc =
                          BlocProvider.of<JobDetailBloc>(context);

                      jobDetailBloc.add(
                        ApplyToJobPostEvent(
                          applyJobPostModel: ApplyJobPostModel(
                              email: _emailController.text.trim(),
                              phoneNumber: _phoneNumberController.text.trim(),
                              text: _messageController.text.trim(),
                              jobID: job['id']),
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

            showDialog(
              context: context,
              builder: (_) {
                return _addReference;
              },
            );
          },
          child: Text('Apply'),
        ),
      );
    },
  );
}

/// _profilePicture() returns a Container widget that has a CircleAvatar widget as its child
///
/// Returns:
///   A Container widget with a CircleAvatar widget as a child.
Widget _profilePicture() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 15,
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
      radius: 50,
      backgroundImage: AssetImage(
        "assets/profile_picture_placeholder.png",
      ),
    ),
  );
}

/// _info() returns a Column widget that contains a Row widget that contains a Text widget that
/// contains the text 'Job Title' and a SizedBox widget that contains a Row widget that contains an
/// Icon widget that contains the icon Icons.location_on and a SizedBox widget that contains a Text
/// widget that contains the text 'Location' and a SizedBox widget that contains a Row widget that
/// contains a Row widget that contains a _pill() widget that contains the text 'Job Type' and a
/// _pill() widget that contains the text 'Salary'
///
/// Returns:
///   A Column widget with 3 rows.
Widget _info(job) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${job["jobTitle"]}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on),
          SizedBox(width: 2),
          Text('${job["location"]}'),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _pill(text: "${job['jobType']}"),
          _pill(text: "${job['salary']} Birr/Month"),
          // _pill(text: "${job['tag']}"),
          // _pill(text: "Company Size: ${job['companySize']}"),
        ],
      ),
      SizedBox(height: 7),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // _pill(text: "${job['jobType']}"),
          // _pill(text: "${job['salary']}"),
          _pill(text: "${job['tag'][0]}"),
          _pill(text: "Company Size: ${job['companySize']}"),
        ],
      ),
    ],
  );
}

/// _pill() is a function that returns a Container widget with a BoxDecoration and a Text widget as its
/// child
///
/// Args:
///   text (String): The text to be displayed in the pill.
///
/// Returns:
///   A Container widget with a BoxDecoration and a Text widget.
Widget _pill({required String text}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 3),
    padding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 223, 218, 218),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Text(
      '$text',
      style: TextStyle(
        fontSize: 13,
      ),
    ),
  );
}

/// _backButton() is a function that returns a GestureDetector widget that contains a Container widget
/// that contains an Icon widget
///
/// Args:
///   context: The context of the widget.
///
/// Returns:
///   A widget that is a container with a child that is an icon.
// ignore: unused_element
Widget _backButton(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Container(
      // decoration: BoxDecoration(color: Colors.lightBlue),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.035,
      ),
      padding: EdgeInsets.only(
        top: 7,
        bottom: 7,
        left: 10,
        right: 10,
      ),
      alignment: Alignment.topLeft,
      child: Icon(
        Icons.arrow_back,
      ),
    ),
  );
}

/// _shortDescription() returns a Row widget that contains an Expanded widget that contains a Container
/// widget that contains a ListTile widget
///
/// Returns:
///   A Row widget with a single Expanded widget with a Container widget with a ListTile widget.
Widget _shortDescription(job) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: "Description: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
                children: [
                  TextSpan(
                    text: '\n${job["description"]}\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              'Posted Date: ${job["postedDate"]}\nPosted By: ${job["companyName"]}',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

/// _reviewSection() is a function that returns a widget that is a SizedBox that has a height of half
/// the screen height and a ListView.builder that has a single child that is a _singleReview() function
///
/// Returns:
///   A SizedBox with a ListView.builder inside of it.
Widget _reviewSection({
  required List reviews,
  required String role,
  required String jobID,
}) {
  // return Builder(builder: (context) {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.5,
  //     child: ListView.builder(
  //       itemBuilder: (context, index) {
  //         return _singleReview();
  //       },
  //     ),
  //   );
  // });

  TextEditingController _reviewController = TextEditingController();

  return Expanded(
    child: Container(
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Reviews",
                style: TextStyle(fontSize: 20),
              ),
            ),
            _reviewField(
                role: role, reviewController: _reviewController, jobID: jobID),
            Column(
              children: reviews.map<Widget>((review) {
                return _singleReview();
              }).toList(),
            )
          ],
        ),
      ),
    ),
  );
}

/// _singleReview() returns a Container widget that contains a ListTile widget
///
/// Returns:
///   A Container widget with a ListTile widget as its child.
Widget _singleReview() {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 7,
    ),
    child: ListTile(
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage("assets/profile_picture_placeholder.png"),
      ),
      title: Text("Name"),
      subtitle: Text("Comment Here..."),
    ),
  );
}

Widget _reviewField({
  required String role,
  required TextEditingController reviewController,
  required String jobID,
}) {
  if (role == "employer") {
    return Container();
  }

  final _formKey = GlobalKey<FormState>();
  return Form(
    key: _formKey,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          TextFormField(
            controller: reviewController,
            decoration: InputDecoration(
              hintText: "Leave your review",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // maxLines: null,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field can\'t be empty.';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 7),
          Builder(builder: (context) {
            return Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  final review = BlocProvider.of<JobDetailBloc>(context);
                  if (_formKey.currentState!.validate()) {
                    review.add(
                      PostReviewEvent(
                        postReviewModel: PostReviewModel(
                          fullName: 'fullName',
                          review: reviewController.text.trim(),
                          jobID: jobID,
                        ),
                      ),
                    );
                  }
                },
                child: Text("Post"),
              ),
            );
          })
        ],
      ),
    ),
  );
}
